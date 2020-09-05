Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC02C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 20:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF24E20796
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 20:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ELv20a6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgIEUpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 16:45:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:52897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgIEUow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 16:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599338645;
        bh=srqAocpg+qFA810VKjx0Q4fyVeb/swOxFzZHhnyTYg4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ELv20a6XJgDEttfp9zoZ4p+RJjgPjUa0PeNl+0OgalamqAyfL7hu+XR0KTcCxoCM4
         6QcZ/PPu6H0osPsI7Y8gJXazKQyjYQUueUW5yWlYF92taNbxXrvYB09LJHdKX7IIW/
         355wLPfE2XjUr8eTGzCNyDh5JtqKpuaozuCDhZfM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6R1-1kmtnS02Ut-00aER8; Sat, 05
 Sep 2020 22:44:05 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-mtd@lists.infradead.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Richard Weinberger <richard@nod.at>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Jaskaran Singh <jaskaransingh7654321@gmail.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] MAINTAINERS: Add ubifs-authentication.rst to UBIFS
Date:   Sat,  5 Sep 2020 22:43:25 +0200
Message-Id: <20200905204326.1378339-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905204326.1378339-1-j.neuschaefer@gmx.net>
References: <20200905204326.1378339-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vHub08Obk2f8katnYdRDwvodrOZOCSe71bpCue3F8Qd4rvhzTSm
 aQvTDKdWAfGK+oaIDMsoZVQGVqOXpapQLdWMKMMNo/mIb3jPySGpn68HqWF+AjxOHgUSoEv
 Wjw5WT0CQ/o47CwDDzhgiTVyNpyDxqAb7uIMDA/RjD6ECivLyFOZdOMMAzjXFpStgndkgZg
 v5ou117OWmn7MxJhEPIZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IMAZyOAfxOw=:hAc5ulTA2IhIW/JWArfXLx
 bM7N5cjYrwYAcx0/E2JWrC0BwrqDZKpt1deaP2JSW4qsx0CQGwIWV3C94bvVHWOqP9w26vqZ5
 FxEb3BPYShxfj4VtznANM+tBot8QpwwuIpbIuYpYN6ZP9NtpFm+ePhsZISTReCT7DSDfJ10SO
 bDxRLY7qpoPdkUxXqKmWN7owcV5kAl4oUMoCWH8vHtO3UqELB5h81i6zN57ZNrMY9F0v+tguo
 040beivG5G2gFNx64zAmssrXa1p698TvSTtYCqa6V1j10nzo2JcCjKSt2qXFpusOGGrhqnDmw
 Pf6J76LeE5IZCFv7L9RdcrJuT8birU9YBbd/v9+FXSYGR5R18D1/wcFIfKTWUvi81+1muqbd7
 ia9p35M97ODZqGhSnnBbDnWouSKeY+rFieqE4PYmCdGDgKu1upraJix1l2HXq4/fPulTgde01
 8iSX5PjnBLKGGWgiQMLwJYWbGBSxr2dk5pd7lIjc9gSpLY8QTNc2FhsWynRDczlv53Se1+9lg
 76nlH/se08LPoftqzFroM82eGGgzwpt2A54ymMxGcUroD0n/xWWDRD/1gT4k+plwuwDofSHQA
 emMYw2tPTxmAlMoqrN0uPhe9U0mZryYwh6GQB2CNvjB5z3ctIy2nL+qwO43Frmnr5mDbbv+x1
 hlqtQcvTQ2JfYbEu2WKNmBjOVFuPkC6H7koBGZJeY/UUmXcoWn0GHv+92s/7ZAF6UQ5SRAJpw
 /lrve9a3i4AxRyf5vM9KiIjksySNNPxdFFa0Ad/adUqvRbW4Qo2MIrx91Mwv1gehx930caDTE
 WwudR4E0lXHEyqghYX7jsx7U1dUEogbDyaonGhfILSqjdJX2eQUsFD7sV8dHPiGmSeFlmnUN8
 /nKm0u/A5cLSkLjTPnrrlHDDMjdfIyhkBkYe4zQTSI6/PzKJ5DIr5rACDB1ERcz5mOuVBRBKi
 3I9AzsSgBh+O3BM79TWuh4cM5wYov8bO1oEygSl9AkcxYe78u4v7Qhb5HRELsh4/a33ATH4gr
 FrjzdxiIGZ5X2/Wns+Bkn3l0mv3nd0jC7dXIxDA6pjxTMw5MFb1k8pvN30bB4ZUHpe2bUoKeL
 zfXYeR0anKC06xI62bcFvKg0o9tdAObA2pA24fyWnFsnKz6/ZV3rEGlGuMjDdNer5n3ME74Fq
 ZYT1U1SMoQLNlx3sSm3678zToCjEQ7qMIza3P11SdoULvrbyrEDvRsH4q1l0lOo3kf9zh2hbV
 TB80RF23uTtFEc5bLyfuBZbyRNe2FS1qBTkoA2Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4647c84c987e..b85671736108e 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17699,6 +17699,7 @@ S:	Supported
 W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git next
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git fixes
+F:	Documentation/filesystems/ubifs-authentication.rst
 F:	Documentation/filesystems/ubifs.rst
 F:	fs/ubifs/

=2D-
2.28.0

