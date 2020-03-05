Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CF6C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F47207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iwtjWCsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgCEHLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:11:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCEHLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 02:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lWq0OMw0zO+XdvNdGLr+tdbOQ9Qrdb6H1NXrslEE0A4=; b=iwtjWCswwY0wonU8Xhr6kW2zdH
        mzUwB6ZLDUIpabc9r17YSzyAlKcclGSC131ZsKD4jkHnGnwh1zexHQCo1VQrAj5N3lLzXvkdMVDTM
        vvGh0bGSbdeswqR50HNkQF6XMOUEzxHrAfxNe77HuChOUzVVie7VXwukK7hFz49Miys1KaLKY8ZSD
        3KdDoGebJbfUNtfqHzUIH+5CX48soosuosQBH0rNYTuvQMXNRg14uC7c+bqG27kd7CpkKTZ3R0CG0
        bvqo40JAHXb3WLKIbgKVavIcaq2HH+FzGWAJOtnEyHx7GlIqIgNA54kfw0oHS04qkJmR5aDkohNi0
        mYdEzfpQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9kfO-0006kO-LN; Thu, 05 Mar 2020 07:11:34 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: chrome platform Kconfig typo
Message-ID: <e5618826-6a5a-08a7-d261-e2eecb1348ce@infradead.org>
Date:   Wed, 4 Mar 2020 23:11:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


from drivers/platform/chrome/Kconfig:

config MFD_CROS_EC
	tristate "Platform support for Chrome hardware (transitional)"
	select CHROME_PLATFORMS
	select CROS_EC
	select CONFIG_MFD_CROS_EC_DEV   <<<<<<<<<<<<<<<<<<<<<<   drop the /CONFIG_/ <<<<<<<<<<<<<<
	depends on X86 || ARM || ARM64 || COMPILE_TEST
	help
	  This is a transitional Kconfig option and will be removed after
	  everyone enables the parts individually.


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
