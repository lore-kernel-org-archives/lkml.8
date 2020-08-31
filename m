Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BD0C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BA320767
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgHaQGV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:06:21 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48615 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgHaQGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:06:20 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id BF220CECCE;
        Mon, 31 Aug 2020 18:16:27 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Bluetooth: fix "list_add double add" in
 hci_conn_complete_evt
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200823010022.938532-1-coiby.xu@gmail.com>
Date:   Mon, 31 Aug 2020 18:06:18 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot+dd768a260f7358adbaf9@syzkaller.appspotmail.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C0A907BA-9C0D-4124-A2AF-3748055DB062@holtmann.org>
References: <000000000000c57f2d05ac4c5b8e@google.com>
 <20200823010022.938532-1-coiby.xu@gmail.com>
To:     Coiby Xu <coiby.xu@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Coiby,

> When two HCI_EV_CONN_COMPLETE event packets with status=0 of the same
> HCI connection are received, device_add would be called twice which
> leads to kobject_add being called twice. Thus duplicate
> (struct hci_conn *conn)->dev.kobj.entry would be inserted into
> (struct hci_conn *conn)->dev.kobj.kset->list.
> 
> This issue can be fixed by checking (struct hci_conn *conn)->debugfs.
> If it's not NULL, it means the HCI connection has been completed and we
> won't duplicate the work as for processing the first
> HCI_EV_CONN_COMPLETE event.

do you have a btmon trace for this happening?

> Reported-and-tested-by: syzbot+dd768a260f7358adbaf9@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=dd768a260f7358adbaf9
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
> net/bluetooth/hci_event.c | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 4b7fc430793c..1233739ce760 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2605,6 +2605,11 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 	}
> 
> 	if (!ev->status) {
> +		if (conn->debugfs) {
> +			bt_dev_err(hdev, "The connection has been completed");
> +			goto unlock;
> +		}
> +

And instead of doing papering over a hole, I would rather detect that the HCI event is not valid since we already received one for this connection.

Regards

Marcel

