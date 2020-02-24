Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AD3C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D29420836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqshzTI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgBXQle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:41:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39399 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbgBXQld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:41:33 -0500
Received: by mail-qk1-f193.google.com with SMTP id e16so6416963qkl.6;
        Mon, 24 Feb 2020 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KgaP9kfhgbQPcLmwOVvyl3qUPWyDRWXIggQgrOZJnPU=;
        b=VqshzTI1c2dtcWeo7t2Iz1lROlK0exHkZtWqTk0/QudIUBDQcTSj/AdNExlGIBjo/G
         tod4bSblMawKNPN7xMYHqMYJjJrW6rWb8S+TmXz34PQ2SNZuKn98VmqpLdMi2JDPla9M
         i6lBZV8Pxy/zciCTWqHrTtvq2QreyPRDS3BE9XIYAiPzNCGI5RzUUnEZYsuu+ydeksmW
         xMQ5P66N5H/KVqH2lmhrxwUS+UPgNRBiu2o+N2zxuYhmX6PHsLqzA6s3TosbK5VgQfaE
         fQ5bkmUDPQAjttOZfFuv4LwpyNl1amGx/t2IjL4mP3jLMCBZt5qPjvBUMGcshVX+l/fr
         qNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KgaP9kfhgbQPcLmwOVvyl3qUPWyDRWXIggQgrOZJnPU=;
        b=L+Gb8i6ZaL2mxvDhG4hLyXY3UdGofI61O3fr9zlTlLL9u7xs1Ez2cjGKIAhxNAwyWB
         KtbQc+TptATORJ/l0Hj20mmwqURRtvNsgMEZsF5ig1OVsI7CSyj979Y0cGHuy9LRtyZd
         QCa+SXQm22AlcttLPN4O+LZtX3jKFUyrxlZqWz2wfoeqWAJ5HP/2wf1O+DxaDRLVKtPn
         wG1BlHqdOqzbxmt2jgQkwWgTJg5BEaBW3AzG6BKdukYA3roXhEeGvjpaj7ozajGcMrGd
         WbqPmvJNbGtisw7nV+ps8MLS6vm6ftF/YJGjx7fXosrk425R6i+YkzCdBNR2k6eCmISu
         qYGg==
X-Gm-Message-State: APjAAAUH3PhIqZNAQUKwYOvFSHSSwHfPM5cHDoIcAsqvQ40qfp4r0zGp
        UIyyiIfkvDC3WjrzFjKSBSM=
X-Google-Smtp-Source: APXvYqyG9rasJcmAxXd/HsQxuO6sM/fXQAyqQlhlbY9+JUzKIR8upAMXrWKSxBZHwBnt4Q3n/hhnnA==
X-Received: by 2002:a37:7a04:: with SMTP id v4mr15387961qkc.246.1582562491536;
        Mon, 24 Feb 2020 08:41:31 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l184sm5913461qkc.107.2020.02.24.08.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 08:41:31 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 24 Feb 2020 11:41:29 -0500
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-tip-commits@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [tip: x86/boot] x86/boot/compressed: Remove .eh_frame section
 from bzImage
Message-ID: <20200224164129.GA312716@rani.riverdale.lan>
References: <20200109150218.16544-2-nivedita@alum.mit.edu>
 <158254422067.28353.10866888120950973607.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158254422067.28353.10866888120950973607.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 11:37:00AM -0000, tip-bot2 for Arvind Sankar wrote:
> The following commit has been merged into the x86/boot branch of tip:
> 
> Commit-ID:     0eea39a234dc52063d14541fabcb2c64516a2328
> Gitweb:        https://git.kernel.org/tip/0eea39a234dc52063d14541fabcb2c64516a2328
> Author:        Arvind Sankar <nivedita@alum.mit.edu>
> AuthorDate:    Thu, 09 Jan 2020 10:02:18 -05:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Mon, 24 Feb 2020 12:30:28 +01:00
> 
> x86/boot/compressed: Remove .eh_frame section from bzImage
> 

Hi Boris, apologies for the confusion and unnecessary work I've created,
but I think the preference is to merge the 2-patch series I posted
yesterday [1] instead of this.

[1] https://lore.kernel.org/lkml/20200223193715.83729-1-nivedita@alum.mit.edu/
