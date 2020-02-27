Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B86C52D29
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DD724688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucS4vl7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbgB0Ob3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:31:29 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33327 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733051AbgB0ODs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:03:48 -0500
Received: by mail-qk1-f193.google.com with SMTP id h4so3222447qkm.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 06:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+wVRmzW/JoYh4wj1/OxvIDIfvZg3+bbPF4TGllHByeo=;
        b=ucS4vl7NZ6uxuuYw5KrBHw8V40FjjznI3n8m8vTE6ErhwUcNpXpvE4mEGhhJfJsn6G
         bZExUUsoO/XZJwHwR/wJVOSWw0IJsJHUUWW89mEwKHWEvxsurD+sTHaoaQM/hBzZKaZH
         kVYbMi0dp2tXVr9gLivoIz08txFzckPldqbm/MnAFAipWWCfzQB1BI8i/r3vifE1jEyq
         TO4WgrUufYjaQRw50jh7A0oJyqb2U3eBWE3LXyA9s9/kedPvi4NjcAyt8td/1aI66nx1
         S3a67qACzLvP30LZVBWbCsEEvG42R4E1tqctIgpnsndNq1QEilWBAZW3xXWTNlPlKI89
         P+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+wVRmzW/JoYh4wj1/OxvIDIfvZg3+bbPF4TGllHByeo=;
        b=jUjvqYM4wG5ahuOImD/c7lJOikvRq4uZ9TWIHrVzaUD3ozNgdEfTxRZ5HUVJvRAI8R
         yc30qGE0pg94hrI2DqveABdMSZJZrBqKNUA7XqoxjUB7f9s7v7Hy5ZGfjtIEuf4MKYQD
         yLNvqXAZkiYRjh5l1MGAsLwfLMDx/qIfTET02nPp9pBvNTtFvlqXp68eQROROV5fagRB
         jnqcOxs/nTo2bch79Kwe5ch8Z9I6MAxJNZtBSmXuQZ0Vr/7qyw2SpZ2CB+RY6njEpven
         akDerfsRQrxUaxl3bv8Qw8hHbEILWyOraOnBGubGicUgELwxbTMDle6zIwRZv4OQsp3b
         v+fw==
X-Gm-Message-State: APjAAAVLehTtfIqBVJn/l7gF+B/tl3F7SHF6/oBNACRxAcjSHe7ETebA
        Dn9AIcDHg6lAe8vTT7IM0qg=
X-Google-Smtp-Source: APXvYqxZJIo+DrVch1xOfdaPRvoZ7Z0gYMGV11K2Vzp3ohBK/+8b3wAuN4lPglvyD6dt0y2cNnZMYw==
X-Received: by 2002:a37:aca:: with SMTP id 193mr5597981qkk.424.1582812225029;
        Thu, 27 Feb 2020 06:03:45 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h34sm3254712qtc.62.2020.02.27.06.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 06:03:44 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BCC22403AD; Thu, 27 Feb 2020 11:03:41 -0300 (-03)
Date:   Thu, 27 Feb 2020 11:03:41 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     zhe.he@windriver.com, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, mhiramat@kernel.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf: probe-file: Check return value of strlist__add
 for -ENOMEM
Message-ID: <20200227140341.GE10761@kernel.org>
References: <1582727404-180095-1-git-send-email-zhe.he@windriver.com>
 <20200226153153.GC217283@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226153153.GC217283@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 26, 2020 at 04:31:53PM +0100, Jiri Olsa escreveu:
> On Wed, Feb 26, 2020 at 10:30:04PM +0800, zhe.he@windriver.com wrote:
> > From: He Zhe <zhe.he@windriver.com>
> > 
> > strlist__add may fail with -ENOMEM. Check it and give debugging hint in
> > advance.
> > 
> > Signed-off-by: He Zhe <zhe.he@windriver.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied,

- Arnaldo
