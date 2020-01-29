Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B496AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8574A206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LSffM5aQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgA2RhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:37:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46044 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgA2RhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:37:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id a6so322311wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 09:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/s6cDvkb8rH6WuQlcXvY/UY9gJge/e/144cD+EfClqw=;
        b=LSffM5aQau2KIj1xQ4qQ7sp51CVktf6GWqpWAoL+5rV+P9ceSt/qBIY7vXoufQ4bwv
         M0Up9Zjaitx3ZBEDwMD7UEDbQ38x5IBg9Cw1GoPh5B+BeFdasmM9jFY3PP2xABmI4Wrv
         0qr6X91tVDNoiVal51slXbM/Xn/idvuRdGo5jZKXcj/vgXqSDd0vGoiVmdsvYU/XYJOq
         q7bi92Gl7inrH7aYJR31pt0zKkMYSzmEoHos6pe/F5rNVgtqIRVJgFSU6MXLWtMoGLPO
         c4F70tfWZ0e968zWZsz0E2sjmON5vSmWFm7wAkSoRfKhr1IriyhSMw1SUqBW071lHN7J
         dH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/s6cDvkb8rH6WuQlcXvY/UY9gJge/e/144cD+EfClqw=;
        b=h87+tDTl3g6UNB/Q5fwT4SLpAud8DZgjOm0Qpn8/SV924qX+avwI6jcls0CqEfMOLz
         VVPgxtKTuv9TwgbAFd2hCk/ejybOjG705Ouv8El/mEoQT92N4LdGdMHEPb5kx1+9ZuZn
         q/tZCywWWiICBgXe+PEXc9MtFeRIkFaIuo9L5+E5l6StQPexNXg95PtShr2SgCvLIy4X
         LMbGfamp5rf/9HqiisYAuEZWJXvZAV2UU3ZJZ6txvs9BT54mbuTJjr7Jrq/Lvc3t+zTA
         0wf66S0btygIL8i6ITuEmXN4QdQJT1EiOroJnJW2yOktbXm0w4JmganM89ofaVOwBRWt
         ga1g==
X-Gm-Message-State: APjAAAXORXZosd0a0F2jwwYkZR8dZbPjcrnRzWFUbNL9Lf4s2Dd8s59O
        +0y9vgoGbU52Ek+6Jn01xJA0KQ==
X-Google-Smtp-Source: APXvYqwNW4frzSA0Sonn9WD6amd1EE0cQ57kkFyXlmU8JUY+N9G0NBjPFhWMJgIIpk/woNYqHJ1z8Q==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr36221601wrv.364.1580319438648;
        Wed, 29 Jan 2020 09:37:18 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id y7sm1516791wrr.56.2020.01.29.09.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 09:37:18 -0800 (PST)
Date:   Wed, 29 Jan 2020 17:37:14 +0000
From:   Quentin Perret <qperret@google.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, maennich@google.com,
        kernel-team@android.com
Subject: Re: [PATCH] kbuild: allow symbol whitelisting with TRIM_UNUSED_KSYMS
Message-ID: <20200129173714.GA193443@google.com>
References: <20200129150612.19200-1-qperret@google.com>
 <nycvar.YSQ.7.76.2001291152540.1655@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.2001291152540.1655@knanqh.ubzr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 Jan 2020 at 12:11:12 (-0500), Nicolas Pitre wrote:
> > diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
> > index a904bf1f5e67..1a6f7f377230 100755
> > --- a/scripts/adjust_autoksyms.sh
> > +++ b/scripts/adjust_autoksyms.sh
> > @@ -48,6 +48,7 @@ cat > "$new_ksyms_file" << EOT
> >  EOT
> >  sed 's/ko$/mod/' modules.order |
> >  xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
> > +cat - $CONFIG_UNUSED_KSYMS_WHITELIST |
> 
> This is a nice trick, however it'll fail if the file path contains 
> spaces or other shell special characters.

Argh! Right, that's a very good point.

> You could try something like 
> this:
> 
> [ -z "$CONFIG_UNUSED_KSYMS_WHITELIST" ] \
> 	&& whitelist= \
> 	|| whitelist="\"$CONFIG_UNUSED_KSYMS_WHITELIST\""
> 
> And then...
> 
>   eval cat - $whitelist | ...
> 
> This way, if $CONFIG_UNUSED_KSYMS_WHITELIST is non empty, it'll get 
> quoted.

A shorter alternative would be something a little like so perhaps ?

diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index 1a6f7f377230..8e1b7f70e800 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -48,7 +48,7 @@ cat > "$new_ksyms_file" << EOT
 EOT
 sed 's/ko$/mod/' modules.order |
 xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
-cat - $CONFIG_UNUSED_KSYMS_WHITELIST |
+cat - "${CONFIG_UNUSED_KSYMS_WHITELIST:-/dev/null}" |
 sort -u |
 sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$new_ksyms_file"

No strong opinion, though.

Thanks for the review,
Quentin
