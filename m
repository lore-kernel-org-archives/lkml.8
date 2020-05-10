Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51B6C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 04:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A602137B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 04:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dmd8yRRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgEJEKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 00:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgEJEKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 00:10:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EE7C061A0C;
        Sat,  9 May 2020 21:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=owAot+qmO/9ju7amjwT7rm5RTL4wob867q4PEFbG3dE=; b=Dmd8yRRmdSG4T/CvAazXNFlHT/
        x5yzajdXUhYDJ6icjQTpl0zweRezH+jGeDQdmwof2Ch2JTfCLzVRZsDa+Yu3PXpvriYaOCi0hs76A
        9jX8R/xvL4xynogDjRUJBlnbfYASpShiPYqWzx5CvGv9UXrcJxTVFZPi5C8vQdPD2fa6qlISqv+EJ
        6D2K+J3slCtrOppYBDURi/2ra8OdbMjsU9ty+JuHRblmH8owhkhMX5QrFbN/Elp/eLMTqbnExOrx0
        kFMCaVhXnnErtp1YcLMT92QVFsEtus0LEKXFvfuLWCMEBuLnYg1p3swVG+bkTQo0NpZjF5xzQRY8l
        PX6rm/YQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXdIL-0000YL-Cq; Sun, 10 May 2020 04:10:29 +0000
Subject: Re: [PATCH v3] kernel: add panic_on_taint
To:     Baoquan He <bhe@redhat.com>, Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        tytso@mit.edu, bunk@kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, labbott@redhat.com, jeffm@suse.com,
        jikos@kernel.org, jeyu@suse.de, tiwai@suse.de, AnDavis@suse.com,
        rpalethorpe@suse.de
References: <20200509135737.622299-1-aquini@redhat.com>
 <20200510025921.GA10165@MiWiFi-R3L-srv>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <acab7971-7522-3511-c976-e0237ceda4d0@infradead.org>
Date:   Sat, 9 May 2020 21:10:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510025921.GA10165@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/20 7:59 PM, Baoquan He wrote:
> Read admin-guide/tainted-kernels.rst, but still do not get what 'G' means.

I interpret 'G' as GPL (strictly it means that no proprietary module has
been loaded).  But I don't see why TAINT_PROPRIETARY_MODULE is the only
taint flag that has a non-blank c_false character.  It could just be blank
also AFAICT.  Then the 'G' would not be there to confuse us.  :)

-- 
~Randy

