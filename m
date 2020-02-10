Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9976FC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B6F20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340127;
	bh=J62eTd3bqr5j/L4W1LyHoRheWIg3gYLbwbNKiE5D1Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GjeNKbvOBfi9RIJcfhv/k5x28Y2NNcWTqe1p1o9MVTI6INRReWIl/HL3ULWNQA3Rk
	 xT7CIzqZ2qgYfh2qnsoYlWl0GMV4gGwmINTW7jD+LR3qAxGA8iPwXQDAeokXQxbaED
	 GmQ4KGa1wLGBdX2lMjwkerZ/ntBuRGaE5hN2Cr1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbgBJNIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbgBJMj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:29 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F31D20733;
        Mon, 10 Feb 2020 12:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338368;
        bh=J62eTd3bqr5j/L4W1LyHoRheWIg3gYLbwbNKiE5D1Fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1vR7aXl5Tq3kwmzDXFioElrNzpJB6SfZ4WarQHMp/qsPzSve0a9njU+y8YyLf0Uf
         350Fl9DmOIFlPK35mBhg+pH6d8tcv3L3v4FW9CY3zxpCsni/H/Oa2jm0eetb+WZdZX
         m/U/RSEZmKsUKq0qQKO0ZAN/QVpmU2cicH5WDlyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+99f4ddade3c22ab0cf23@syzkaller.appspotmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>
Subject: [PATCH 5.5 037/367] rcu: Use READ_ONCE() for ->expmask in rcu_read_unlock_special()
Date:   Mon, 10 Feb 2020 04:29:10 -0800
Message-Id: <20200210122427.406919433@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul E. McKenney <paulmck@kernel.org>

commit c51f83c315c392d9776c33eb16a2fe1349d65c7f upstream.

The rcu_node structure's ->expmask field is updated only when holding the
->lock, but is also accessed locklessly.  This means that all ->expmask
updates must use WRITE_ONCE() and all reads carried out without holding
->lock must use READ_ONCE().  This commit therefore changes the lockless
->expmask read in rcu_read_unlock_special() to use READ_ONCE().

Reported-by: syzbot+99f4ddade3c22ab0cf23@syzkaller.appspotmail.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/rcu/tree_plugin.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -612,7 +612,7 @@ static void rcu_read_unlock_special(stru
 
 		t->rcu_read_unlock_special.b.exp_hint = false;
 		exp = (t->rcu_blocked_node && t->rcu_blocked_node->exp_tasks) ||
-		      (rdp->grpmask & rnp->expmask) ||
+		      (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
 		      tick_nohz_full_cpu(rdp->cpu);
 		// Need to defer quiescent state until everything is enabled.
 		if (irqs_were_disabled && use_softirq &&


