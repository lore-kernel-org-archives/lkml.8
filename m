Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD65EC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909402073D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTccfNpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAMG7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:59:07 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46476 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgAMG7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:59:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id 13so7269187oij.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 22:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7/UtBkPMSiH7OPumVVkpC9qQ7v7Gjsz6vO3I1/KijSA=;
        b=dTccfNpd4Wf3a69ab7uP6FdWG4KVQj+iadiI5+vEYFQkBQz6+L27hWKO6Tr/8BqamM
         Nm3DdJBlG2bmSGDXzTlJ7ME+wB+rT5aZakK+1EeK20R4w76oxfWdhQMSYiSMd5YSzEtf
         XsFi40T/lSkYaraZ4zpP47y/oWvNWDT4tllq5P1DXUr670L50/k8p2jkJrR+4YnDsVAP
         ZsA8MmjYKI1l+PlozRop1VYIizIPzam/w1wxvEoqgCIZ5j4Sd/+q//0sU0ky5JbGmmZW
         QxtnsPYRI0lRtkcN7743sloZmRRsL/uxU/RB1rPTKRpHX/4ECN2Dbbu1M/YDacs+YrnT
         rZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7/UtBkPMSiH7OPumVVkpC9qQ7v7Gjsz6vO3I1/KijSA=;
        b=kZreVEQWquexpYGpZ21mj+C24QGF4qaedtP7eIkJeEJd8H1jV8jnmqkGcgwLoGomS9
         fudBHo5hsTM9S6u/cCS2tz8RUE8nMxcRHlX3SSYZPhOzs/VMhB3hYLZYtdI4Jy8hJ7N5
         2lrjCDnOaeIvby7dtlzM1lr6xyWlLiBVdL9xD6N/qMk2N/slXNRj14239SAZBFoa2xqx
         yiH+8qwcV3cnWclioFRKmVD8z01Mc2UP2URyWovdbSMqfeZNlpov1q90dbXfAXx/9skc
         u+B/AT1nlLuFPESdYSKk0WOEKnldNTqTAlpBplMc9lWDsIlPa07hbIF62s2MfHpoNxny
         726g==
X-Gm-Message-State: APjAAAUXIp9EFpbA4FO9USyqEiy0419W5PXCF9pFoZieqNHYyaSBQ6md
        relyGsKqaWvBlnCFwly/7Rmpyw==
X-Google-Smtp-Source: APXvYqxglLp2bFVZRZKGR+F54MeXIF0YeSvulPEEgpGaNKQj8rO0K5eTGC88eZfJix6E0czRa8Kd4g==
X-Received: by 2002:aca:aac3:: with SMTP id t186mr11714916oie.71.1578898746074;
        Sun, 12 Jan 2020 22:59:06 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n7sm3253475oij.14.2020.01.12.22.59.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Jan 2020 22:59:05 -0800 (PST)
Date:   Sun, 12 Jan 2020 22:58:52 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Mikael Magnusson <mikachu@gmail.com>
cc:     david@fromorbit.com, akpm@linux-foundation.org, amir73il@gmail.com,
        chris@chrisdown.name, hannes@cmpxchg.org, hughd@google.com,
        jlayton@kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, tj@kernel.org, viro@zeniv.linux.org
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
In-Reply-To: <20200108143752.9475-1-mikachu@gmail.com>
Message-ID: <alpine.LSU.2.11.2001122253550.3471@eggly.anvils>
References: <20200107001039.GM23195@dread.disaster.area> <20200108143752.9475-1-mikachu@gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2020, Mikael Magnusson wrote:
> 
> It's unfortunately not true that everything handles this correctly.
> 32-bit binaries for games on Steam that use stat() without the 64 is
> so prevalent that I got tired of adding the LD_PRELOAD wrapper script
> and just patched out the EOVERFLOW return from glibc instead. (They
> obviously don't care about the inode value at all, and I don't use any
> other 32-bit binaries that do). This is probably a class of binaries
> you don't care very much about, and not very likely to be installed on
> a tmpfs that has wrapped around, but I thought it was worth mentioning
> that they do exist anyway.

Thank you for alerting us to reality, Mikael: not what any of us wanted
to hear, but we do care about them, and it was well worth mentioning.

Hugh
