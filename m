Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F78CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3B6206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363990;
	bh=Oa+q0KIYYDTnW/Wjd+DAuMGDs+zRTcpchmQ85aZUICE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FXb1/sMWh2W39wjWzNfPocoi82B7zIRpEJ9t2DeH41/oYmjIqWvlbh7skH40VoX3n
	 clicsR9HnhxCG6J3Q7H5CZlg6EmFPQhoqNHoXhOps+gm2GPcE9HtEuAyAnjVW98yQE
	 ghDppODL2afzn/1VaERyvgCfRgsxBQfRhrZekXsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbgEMJww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387833AbgEMJwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:52:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9E29206D6;
        Wed, 13 May 2020 09:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363565;
        bh=Oa+q0KIYYDTnW/Wjd+DAuMGDs+zRTcpchmQ85aZUICE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bUwxdjBnUbDsqimmBu2zx6izP6Ydb1KR0DXcHl8E+5selFiX+lvpXP/GsLTRPWKT4
         DwK+o4FKPakpQVAZsOwbmyQNlm7ZLl44IhJ3f9GaBMHc2Vm8UcvnpJNbVO5sgZwsK8
         qGK4nFJS2ewlgjYgpwjoacIbOBwvZkh1RepV12Ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot+0251e883fe39e7a0cb0a@syzkaller.appspotmail.com,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 036/118] sch_sfq: validate silly quantum values
Date:   Wed, 13 May 2020 11:44:15 +0200
Message-Id: <20200513094420.600244790@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit df4953e4e997e273501339f607b77953772e3559 ]

syzbot managed to set up sfq so that q->scaled_quantum was zero,
triggering an infinite loop in sfq_dequeue()

More generally, we must only accept quantum between 1 and 2^18 - 7,
meaning scaled_quantum must be in [1, 0x7FFF] range.

Otherwise, we also could have a loop in sfq_dequeue()
if scaled_quantum happens to be 0x8000, since slot->allot
could indefinitely switch between 0 and 0x8000.

Fixes: eeaeb068f139 ("sch_sfq: allow big packets and be fair")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+0251e883fe39e7a0cb0a@syzkaller.appspotmail.com
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_sfq.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -637,6 +637,15 @@ static int sfq_change(struct Qdisc *sch,
 	if (ctl->divisor &&
 	    (!is_power_of_2(ctl->divisor) || ctl->divisor > 65536))
 		return -EINVAL;
+
+	/* slot->allot is a short, make sure quantum is not too big. */
+	if (ctl->quantum) {
+		unsigned int scaled = SFQ_ALLOT_SIZE(ctl->quantum);
+
+		if (scaled <= 0 || scaled > SHRT_MAX)
+			return -EINVAL;
+	}
+
 	if (ctl_v1 && !red_check_params(ctl_v1->qth_min, ctl_v1->qth_max,
 					ctl_v1->Wlog))
 		return -EINVAL;


