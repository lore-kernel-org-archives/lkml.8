Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CDAC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA0320838
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abBc9p7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgCDVhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:37:15 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41074 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgCDVhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:37:15 -0500
Received: by mail-ed1-f65.google.com with SMTP id m25so4084461edq.8;
        Wed, 04 Mar 2020 13:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7EWuPye2IQ0nQ3hhMjiZUg2bsHegQirK4H8OZ3TCO+4=;
        b=abBc9p7CcSwymEHNn7AcCZ+4cgL2pYwzhoz9poeSH1aYPSRpXwyeOWH9p2XiElHWIo
         YkJZAKAbVFtzQter15+dpXS7ghMRkzbx13rC831m1SBTmXJwUJacbzGFMrtZC2xwhw7q
         kdC9pzt0vvvzAvlfyczIte9BtSJH0fRIOo4XNR+tqLZUtNusqSPEDs7bbzFEoMrTfVBa
         S45s8fI7xhSaRZpL5XkjA//1a1J/Pl8M6JyFY1/I+YYAwuYMIXPeA4E1Zpfkty++RnDF
         KWzSMA1l9vZeiEvRyB/7pqqIhuLzNYU9v8XoSBHncirZlCdLSz2bsCctBdb3Rxo3lBd2
         to2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7EWuPye2IQ0nQ3hhMjiZUg2bsHegQirK4H8OZ3TCO+4=;
        b=pCEr4+KAuBw6+JlFbtVxevMO5rB8eD3fUKxBavQ0LOmA6FAfg4YtZwSvEpr7TDTtSY
         6gPnHx+Cn5fL4vOis0oTFeHLw8noVZjvpXFgm2nhaPtL5PWc2j/KSOyrsUkO82NmIdMo
         jUkf04gWuYgEr4vae1s8PH1r6cSjXfrjn2v5tPyewmvMez9C7yxDt29dsVfd/JLu+3Mo
         q3dAA3a6g4CFsQVRiRiuAlE/x2yqeEHOve/Dipe4xVa9gGvQDwX6jSzAM8g8C67AfF4w
         er3B//6gz1QbZpduBa6BkHR9bvlvzlqfEWZ3h5tIqManK/oNLU28RMVHed3Yo790XDMx
         ZEQQ==
X-Gm-Message-State: ANhLgQ0b1jrAYgDMJL3DkqRf1ukw2sd1y+zF+Qlpg13f+Q+QTeHe0nCl
        eiDKlo7HJXK8R56YL7F3iep8+ceQtyw=
X-Google-Smtp-Source: ADFU+vuChrrcPW2yThE0B3NwkMmZJE4fn+t7slsyYjJekViQRnDD/6nvXI6brVfBQtNid5R5V9bB4A==
X-Received: by 2002:a17:906:14d6:: with SMTP id y22mr4220846ejc.289.1583357833083;
        Wed, 04 Mar 2020 13:37:13 -0800 (PST)
Received: from felia ([2001:16b8:2d16:4100:5c62:5f:595c:f76d])
        by smtp.gmail.com with ESMTPSA id h5sm1354486ejt.91.2020.03.04.13.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:37:12 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 4 Mar 2020 22:37:08 +0100 (CET)
X-X-Sender: lukas@felia
To:     Sameer Rahmani <lxsameer@gnu.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to kobject doc ReST conversion
In-Reply-To: <959e8f4c-9ff6-4388-9b6f-23f6e548e9e5@gnu.org>
Message-ID: <alpine.DEB.2.21.2003042230100.2698@felia>
References: <20200304110821.7243-1-lukas.bulwahn@gmail.com> <959e8f4c-9ff6-4388-9b6f-23f6e548e9e5@gnu.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Mar 2020, Sameer Rahmani wrote:
> 
> Thanks for the fix. It looks good to me
> 
> 

Sameer, in the kernel community, there is the convention to acknowledge a 
patch with responses, such as Acked-by or Reviewed-by. Maintainer scripts 
then allow the maintainer to pick those up automatically from the 
responses. So, you would respond in a new line with "Acked-by: your full 
name <your email address>".

You can read more on that here:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

I hope this helps and is interesting to you.

Thanks for your review and quick response to my patch,

Lukas
