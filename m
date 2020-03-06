Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CB5C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75826206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvgNX6L3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgCFVSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:18:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36063 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFVSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:18:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id s5so77046wrg.3;
        Fri, 06 Mar 2020 13:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=p6Org6UXIrzDwowUXc2sjZeWM3eA1JdxHEoOPSQKwXg=;
        b=cvgNX6L3bTfW2fGWA9k22gcf/KhCHZ9ExnPWWJEErpHTmKDq30VAynAmceOCadITbe
         I/ExetjXaPI4YG2nj4ajs3z2T/iWQdO0nqn9HkOH1c2CdJV9fm3SzNsq7Qhu68hKffLl
         NljWlntUtHdt1GtrTEZTM1Rm6MI9ZOF2QPeT8xowEvR8nw1iLmBEx05LLIhIKCYcfqKX
         LoZHsHk2poTWDEIpxVJOcxD5qIbNak2Gx6Sgu572c6FB6fDQ2scdhTU8RIgH7bn39sqL
         +3KC0mmOfZlhbTPKYfy6n5vQxf5h4CaG7Ze3L36TSdJJ+ffROSEHbxGwELOvRHynl0N5
         Kpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=p6Org6UXIrzDwowUXc2sjZeWM3eA1JdxHEoOPSQKwXg=;
        b=ZMpA0na8SjSEHE4we5WBwOM+eU6q+vNgC9vfySzZzpqxcbhJ6dCp0iyiYNasuZK8V4
         12FSHzuTH02eTIyR5jPbx/yIdwIyyV2rnq/4ohRyKIQTtkLSc62NjUWSVRX1IxN+9EBP
         qOE4aaHRVED9rjvqnG1WSHcyuwvMJVvSQKMH2ShTkQHGWsaknvkv7HO6WNKxYUAHaJvJ
         j1c0F4bp2h3VtHrwS8PFFddg7G4oIGh0jhgXW7Zub8VXsMFgWHixsbnVk17BE8GGDw5l
         wNapD2dQkboaOZCqUxms0E03/d1I7sMzxg4pZJj1oNk7Tljq5irK7Hwej/Tb6c6cf0nR
         hdAA==
X-Gm-Message-State: ANhLgQ0x2Sm80BEAn4AzX4QK2KeUudkCHvuF6/MrneqMWmVd6z1DueYd
        c6mpFE0YGM9FaV5yHRNiHCY=
X-Google-Smtp-Source: ADFU+vsVLlePqEyfb4RvbS3zrbvkxMTYwO8c1UN9KLRwWFNh+J1N+jIVCdVfuDojuHpXx4saKzQBdg==
X-Received: by 2002:a5d:66cc:: with SMTP id k12mr661050wrw.157.1583529479110;
        Fri, 06 Mar 2020 13:17:59 -0800 (PST)
Received: from felia ([2001:16b8:2d12:b200:a423:5ade:d131:da88])
        by smtp.gmail.com with ESMTPSA id q16sm35313652wrj.73.2020.03.06.13.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 13:17:58 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 6 Mar 2020 22:17:49 +0100 (CET)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
In-Reply-To: <e43f0cf0117fbfa8fe8c7e62538fd47a24b4657a.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2003062214500.5521@felia>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com> <20200304131035.731a3947@lwn.net> <alpine.DEB.2.21.2003042145340.2698@felia> <e43f0cf0117fbfa8fe8c7e62538fd47a24b4657a.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Mar 2020, Joe Perches wrote:

> On Wed, 2020-03-04 at 21:50 +0100, Lukas Bulwahn wrote:
> > 
> > On Wed, 4 Mar 2020, Jonathan Corbet wrote:
> > 
> > > On Wed,  4 Mar 2020 08:29:50 +0100
> > > Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > > > Jonathan, pick pick this patch for doc-next.
> > > 
> > > Sigh, I need to work a MAINTAINERS check into my workflow...
> > > 
> > 
> > I getting closer to have zero warnings on the MAINTAINER file matches and 
> > then, I would set up a bot following the mailing lists to warn when anyone
> > sends a patch that potentially introduces such warning.
> 
> Hey Lukas.
> 
> I wrote a hacky script that sent emails
> for invalid MAINTAINER F: and X: patterns
> a couple years back.
> 
> I ran it in September 2018 and March 2019.
> 
> It's attached if you want to play with it.
> The email sending bit is commented out.
> 
> The script is used like:
> 
> $ perl ./scripts/get_maintainer.pl --self-test=patterns | \
>   cut -f2 -d: | \
>   while read line ; do \
>     perl ./dump_section.perl $line \
>   done
> 

Thanks, Joe. That is certainly helpful, I will try to make use of it in 
the future; fortunately, there really not too many invalid F: patterns 
left, and I can send the last few patches out myself.

Lukas
 
