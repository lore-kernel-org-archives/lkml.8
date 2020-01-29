Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2DBC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 03:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01D621739
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 03:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgA2Dzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:55:55 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50530 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgA2Dzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 22:55:54 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4D713CECE7;
        Wed, 29 Jan 2020 05:05:13 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH 1/1] Bluetooth: Fix refcount use-after-free issue
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200128105322.1.If741898c727a5d948cbb10fdf9225b84efd443c8@changeid>
Date:   Wed, 29 Jan 2020 04:55:52 +0100
Cc:     Yoni Shavit <yshavit@chromium.org>,
        linux-bluetooth@vger.kernel.org,
        Alain Michaud <alainmichaud@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <49CDADD8-2079-4E65-996A-4090BB85BBAE@holtmann.org>
References: <20200128185414.158541-1-mmandlik@google.com>
 <20200128105322.1.If741898c727a5d948cbb10fdf9225b84efd443c8@changeid>
To:     Manish Mandlik <mmandlik@google.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manish,

> There is no lock preventing both l2cap_sock_release() and
> chan->ops->close() from running at the same time.
> 
> If we consider Thread A running l2cap_chan_timeout() and Thread B running
> l2cap_sock_release(), expected behavior is:
> A::l2cap_chan_timeout()->l2cap_chan_close()->l2cap_sock_teardown_cb()
> A::l2cap_chan_timeout()->l2cap_sock_close_cb()->l2cap_sock_kill()
> B::l2cap_sock_release()->sock_orphan()
> B::l2cap_sock_release()->l2cap_sock_kill()
> 
> where,
> sock_orphan() clears "sk->sk_socket" and l2cap_sock_teardown_cb() marks
> socket as SOCK_ZAPPED.
> 
> In l2cap_sock_kill(), there is an "if-statement" that checks if both
> sock_orphan() and sock_teardown() has been run i.e. sk->sk_socket is NULL
> and socket is marked as SOCK_ZAPPED. Socket is killed if the condition is
> satisfied.
> 
> In the race condition, following occurs:
> A::l2cap_chan_timeout()->l2cap_chan_close()->l2cap_sock_teardown_cb()
> B::l2cap_sock_release()->sock_orphan()
> B::l2cap_sock_release()->l2cap_sock_kill()
> A::l2cap_chan_timeout()->l2cap_sock_close_cb()->l2cap_sock_kill()
> 
> In this scenario, "if-statement" is true in both B::l2cap_sock_kill() and
> A::l2cap_sock_kill() and we hit "refcount: underflow; use-after-free" bug.
> 
> Similar condition occurs at other places where teardown/sock_kill is
> happening:
> l2cap_disconnect_rsp()->l2cap_chan_del()->l2cap_sock_teardown_cb()
> l2cap_disconnect_rsp()->l2cap_sock_close_cb()->l2cap_sock_kill()
> 
> l2cap_conn_del()->l2cap_chan_del()->l2cap_sock_teardown_cb()
> l2cap_conn_del()->l2cap_sock_close_cb()->l2cap_sock_kill()
> 
> l2cap_disconnect_req()->l2cap_chan_del()->l2cap_sock_teardown_cb()
> l2cap_disconnect_req()->l2cap_sock_close_cb()->l2cap_sock_kill()
> 
> l2cap_sock_cleanup_listen()->l2cap_chan_close()->l2cap_sock_teardown_cb()
> l2cap_sock_cleanup_listen()->l2cap_sock_kill()
> 
> Protect teardown/sock_kill and orphan/sock_kill by adding hold_lock on
> l2cap channel to ensure that the socket is killed only after marked as
> zapped and orphan.
> 
> Signed-off-by: Manish Mandlik <mmandlik@google.com>
> ---
> 
> net/bluetooth/l2cap_core.c | 26 +++++++++++++++-----------
> net/bluetooth/l2cap_sock.c | 16 +++++++++++++---
> 2 files changed, 28 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

