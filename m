Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B94C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 085A02087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599586914;
	bh=91Gqg5YLLWCl7uSrXUPVOd54T0t/ILdHmraqvDw6d4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LK7qeXdPj6UTXTd2HORBme+0J63wp2J5MSvPcdoaeHJkzzS1sUWx+hAGqbtwX57nD
	 t7YMv1O5ZNOD/RnlYoFDwQaGYMhJUA8jH0x6/EeZ+N/zBzzRBYEYF0lKgYoub3gmDJ
	 pD+XM/3Z+KJysKNkXcxkn6JfJgNrs1ZO0zpgGPHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbgIHRlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731662AbgIHQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:14:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8DAC0617A5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:13:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so21046276ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qrnyg2Jm0ZMDLhfMDLTPa3q/hqhgWjGbjcB9r/1C63U=;
        b=U3SDmAze50USY6EovyILAG+puSbqW7D7ip6u6MXQ/FbqvLAPHNn30z1mlZCWf9PgAg
         kkNHd4g+BQhNUO0oNqBxtzmPfO9RSFtCLyAOGoGxU3CTKU8MlgrNPbVYx3ZPTs61WQNz
         vUWVaTiypQvTyLaxrbqzhN+WJHVFXskWi+pG1TwPJPx6nNeIga/i9/SvjwqLeyLkU9h2
         mRB0hvr1a/7qEik/7UT5Fl5VlgcQiogu2cidPZ04KU5xjQr/osjHnDx2SEB4VJEX/Xu1
         NmIT1Va3IQ7R4Y7bQu+RfbRcoZk9C2HRc9AL/9bi/Su6TAwiAqjdGeNdS74tm9iI/P4m
         jSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qrnyg2Jm0ZMDLhfMDLTPa3q/hqhgWjGbjcB9r/1C63U=;
        b=eWpEeo3M40MKtsZkqvIvT+r3bNw5ZL/ve5eWtnvu8sMda60qRqm72L3wFIYB85Zpix
         N9HLTFbVLOOTfnuIuEatIHgCjQCVlGzXkiNmzecTOlJ8muDp/16LZCd3AOxs+Cn0OoRL
         jnf8p/jQWNOMgLxV+Ri2ehAtvi5/j6YK/7h5bAzgnDqmoFnMTN4XmmnXYwz5XDViMRnE
         Ok2AUVaJLVud7+p165lWSXR5g3+5O7jW8z47G5td2hECrgOd2YNxedXj7Qn21WAyDEiB
         R4plM/O6flMleqcU1uLjE2PC4zRgGPFA5sRnADC8vrfsEu0lqIRJPnauFs3H/tl5CJfy
         dk5Q==
X-Gm-Message-State: AOAM533+8vKo0Z7cUXqDnWdeik0o3UyzvVA3rVOizykGHo6+z2nD6w4x
        ekmoIFh7d9sctnNBVrRKAAFuHp2g/yg=
X-Google-Smtp-Source: ABdhPJz4O+W2UMQDvNCEIHRBYt3Ewv2ciklxjXsveuRs/pJ7sj0BnUZDveM8j9RTN3Pv4eYDPTc8NQ==
X-Received: by 2002:a17:906:f43:: with SMTP id h3mr25099270ejj.338.1599567237152;
        Tue, 08 Sep 2020 05:13:57 -0700 (PDT)
Received: from gmail.com (54007801.dsl.pool.telekom.hu. [84.0.120.1])
        by smtp.gmail.com with ESMTPSA id z23sm17481645eja.29.2020.09.08.05.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:13:56 -0700 (PDT)
Date:   Tue, 8 Sep 2020 14:13:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v1] x86/defconfigs: Unbreak 32-bit defconfig builds
Message-ID: <20200908121354.GA3848343@gmail.com>
References: <20200908100018.50188-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908100018.50188-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> After the commit 1d0e12fd3a84 ("x86/defconfigs: Refresh defconfig files")
> 32-bit builds using defconfig become broken because on x86_64 build host
> with no ARCH provided the default behaviour is to assume 64-bit independently
> on the configuration file name. The crucial part is CONFIG_64BIT option
> that used to be explicit. Let restore the latter option in order to unbreak
> 32-bit builds.

So exactly which build method broke due to this? The typical way to do a defconfig build is:

  make ARCH=i386 defconfig

which still works fine AFAICS.

Thanks,

	Ingo
