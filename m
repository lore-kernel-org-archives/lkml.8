Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C79CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1A2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577587;
	bh=u/0ZqK8dt9XK1q2f+clP9/xK0hXJJC12WcXKPRY2uK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wJt7qunLExA0Fi/3V+DhMB15RAvw5lsuit5FJSSxOtAb65oo0pPRN8v8RgxADMxAo
	 6x9OB5SLj5nBalZMvDlRZq14no/h1DnSiqpXGIaodOg+A4OLxxU1oxIJf7RUggHYFL
	 eU8HQUbYmbedG8JqmWyYDz3EiFXqOcBYQaSx0tmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbgFSOjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:39:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388040AbgFSOje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:39:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97D7621527;
        Fri, 19 Jun 2020 14:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577574;
        bh=u/0ZqK8dt9XK1q2f+clP9/xK0hXJJC12WcXKPRY2uK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNrcOXsA7KZNDn5cTGGUkQkWomQfwg3ncDaHLTVtKdgmMoTzjccNwMTjWqAwv+yIM
         JbX9Rx4OZKTM9FUy0uWk6TMVfp26qb6NIMbLXkJywvLVzsUY0/vmY+gIbQBnec+4W/
         tAQYvGqDwjjwwZNcbBVdYRmT8Pqk6n1fCF+1S9h4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.de>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.4 097/101] sunrpc: svcauth_gss_register_pseudoflavor must reject duplicate registrations.
Date:   Fri, 19 Jun 2020 16:33:26 +0200
Message-Id: <20200619141619.059564972@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141614.001544111@linuxfoundation.org>
References: <20200619141614.001544111@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.de>

commit d47a5dc2888fd1b94adf1553068b8dad76cec96c upstream.

There is no valid case for supporting duplicate pseudoflavor
registrations.
Currently the silent acceptance of such registrations is hiding a bug.
The rpcsec_gss_krb5 module registers 2 flavours but does not unregister
them, so if you load, unload, reload the module, it will happily
continue to use the old registration which now has pointers to the
memory were the module was originally loaded.  This could lead to
unexpected results.

So disallow duplicate registrations.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206651
Cc: stable@vger.kernel.org (v2.6.12+)
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/auth_gss/svcauth_gss.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -789,9 +789,11 @@ svcauth_gss_register_pseudoflavor(u32 ps
 	new->h.flavour = &svcauthops_gss;
 	new->pseudoflavor = pseudoflavor;
 
-	stat = 0;
 	test = auth_domain_lookup(name, &new->h);
-	if (test != &new->h) { /* Duplicate registration */
+	if (test != &new->h) {
+		pr_warn("svc: duplicate registration of gss pseudo flavour %s.\n",
+			name);
+		stat = -EADDRINUSE;
 		auth_domain_put(test);
 		kfree(new->h.name);
 		goto out_free_dom;


