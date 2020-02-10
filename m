Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F5EC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 03:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB68C2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 03:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CxvI5To5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgBJDbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 22:31:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJDbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 22:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wNZXPvSuwWsk5yYj2RHLPyRevK9x31/K0sTV5UWSPow=; b=CxvI5To5PPEgPiidlqEvla5lUs
        gLIBFhQm4ueAQuE+8lPJMBG3601xpX2S7bfDrw9ZhVGHIZtQt6kuff+apt3V1ffyVfTiLGvrud9UK
        eOHDbk/6ZngFO5n/Y4gdjWet0KIkm/vmJzobhXMdAx6aUKZdGi34030YUbmXdJHBYExzkfP0EW4DU
        gtrVh5ksWFhzskRkvvEtI8MOJALm25jGGv1QtSo7GWfOWo+Scfqnrjy2OX12EaYMKHmkzrhxBylk7
        xsl+kZNEy+jOl+YJyxfXmwKkkNqZSTx9+8prsPWOXGIqSNIEasSNhPXl0DAGgGBElKCBIQxmTV6tq
        sLlR3SfA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j0zmx-0001hI-SN; Mon, 10 Feb 2020 03:31:11 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: kunit: fix Sphinx directive warning
Message-ID: <9e787393-703b-ce56-8258-8dcf0cd5ff11@infradead.org>
Date:   Sun, 9 Feb 2020 19:31:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Documentation warning due to missing a blank line after a directive:

linux/Documentation/dev-tools/kunit/usage.rst:553: WARNING: Error in "code-block" directive:
maximum 1 argument(s) allowed, 3 supplied.
.. code-block:: bash
        modprobe example-test

Fixes: 6ae2bfd3df06 ("kunit: update documentation to describe module-based build")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Knut Omang <knut.omang@oracle.com>
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/dev-tools/kunit/usage.rst |    1 +
 1 file changed, 1 insertion(+)

--- lnx-56-rc1.orig/Documentation/dev-tools/kunit/usage.rst
+++ lnx-56-rc1/Documentation/dev-tools/kunit/usage.rst
@@ -551,6 +551,7 @@ options to your ``.config``:
 Once the kernel is built and installed, a simple
 
 .. code-block:: bash
+
 	modprobe example-test
 
 ...will run the tests.

