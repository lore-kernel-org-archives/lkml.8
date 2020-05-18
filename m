Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4311C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D01207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824494;
	bh=40Q/C6SFVyCjEJuhhMnHIsqJzziyUgPkWeVg8jziGjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1+BxnV3EekgQmHH7xA2gbgWzkrrUHXqnZuYVFTO3KaAgPoI4DiV8PV4T1jHSsYKAs
	 sR1z6Ba9MJo4d0iElQ3T2GxCdq1VwP9CdK2LNX0ikdVMM1fCETeDN+771IQJ1rr3QX
	 aklfgZSfCcE4gema8XH7KPsGLN8H1yXY/RcNoFDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbgERRyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbgERRyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:54:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0C8120674;
        Mon, 18 May 2020 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824490;
        bh=40Q/C6SFVyCjEJuhhMnHIsqJzziyUgPkWeVg8jziGjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYzPh6c+0wH+dJLPgIwBt2UPBDKxOF9syOWzm/UAhszw3YyBng2BQbAgaE0dSbWwX
         snDt6aL7VXiKJXA6KMefaoUB/3G4TytNh4rJ8SSshGVj1gpIcXLLDJzZSlrmei7A7K
         ndXeqz4S/5tb0BuzqhECnHiaVGkEDKnJmkYYDFKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Walters <walters@redhat.com>
Subject: [PATCH 5.4 031/147] net: ipv4: really enforce backoff for redirects
Date:   Mon, 18 May 2020 19:35:54 +0200
Message-Id: <20200518173518.050636898@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 57644431a6c2faac5d754ebd35780cf43a531b1a ]

In commit b406472b5ad7 ("net: ipv4: avoid mixed n_redirects and
rate_tokens usage") I missed the fact that a 0 'rate_tokens' will
bypass the backoff algorithm.

Since rate_tokens is cleared after a redirect silence, and never
incremented on redirects, if the host keeps receiving packets
requiring redirect it will reply ignoring the backoff.

Additionally, the 'rate_last' field will be updated with the
cadence of the ingress packet requiring redirect. If that rate is
high enough, that will prevent the host from generating any
other kind of ICMP messages

The check for a zero 'rate_tokens' value was likely a shortcut
to avoid the more complex backoff algorithm after a redirect
silence period. Address the issue checking for 'n_redirects'
instead, which is incremented on successful redirect, and
does not interfere with other ICMP replies.

Fixes: b406472b5ad7 ("net: ipv4: avoid mixed n_redirects and rate_tokens usage")
Reported-and-tested-by: Colin Walters <walters@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -914,7 +914,7 @@ void ip_rt_send_redirect(struct sk_buff
 	/* Check for load limit; set rate_last to the latest sent
 	 * redirect.
 	 */
-	if (peer->rate_tokens == 0 ||
+	if (peer->n_redirects == 0 ||
 	    time_after(jiffies,
 		       (peer->rate_last +
 			(ip_rt_redirect_load << peer->n_redirects)))) {


