Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70147C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9EF215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpA5X10B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgAaRlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:41:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33109 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgAaRlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 12:41:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so9709469wrq.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 09:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dB53pippwc9Cw99NKYUYznHPUB2hFZaxJZFvVBO7aqs=;
        b=qpA5X10BTpYcTnqANydfOePRDFfM5juSOr2qFtgr27XSiXpOSD0IScgAJEwmmd3JpW
         DUGpMKZH52zTS/SqVObyGMJamkdBaepDzrxfRSKKSx70INGNrdfrqBEybgcz3N3+Trxb
         tprd/87tUYHn7uS2VA4tKsORGaWUnAvXKEJKYKxc4Keq+CSauqjMeo6m+Ah09LWtRfGp
         jqBpJXT8XRN08SMdk8ZdtzHdPYWtsi45xHulVXlPB0Tjx/IrgEpbLeCDeFV61E5iHvvd
         GBTg+gJbhlZtRsq9tomfDlWJ+vJYk2QLTg7E53cAy6ahljt/PvLoiQaWmO/vUtJdyMqU
         ZXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dB53pippwc9Cw99NKYUYznHPUB2hFZaxJZFvVBO7aqs=;
        b=JZ+sEo9NwftvFsgs5UGDUT8yS7JfKvxO3hDfd+6KEihkrb6awedPMHQ8QbG2p0r71V
         zRJZdBLv0T0Fp4ItkfhZbCCw7vhTzTarIfCAiqcgeB51kHvAjjVsdJfSuwta1dc+QXHz
         UjP8Tj/v63HaIuxEtIJ8nPduOpN3oj1EvAxpxXKYEqyeF9a49hsVM/oku5OEOGMUsV/D
         /pHfrWJtwPlMrKD9mwRmm5kKuFMkjlW2rzphgVs0bFiq4FsrEdfl6ANBnOkt3iYfTRvb
         +f2Yu58RD5saspxI9cvJPRuVH3Ce7/tynYMkziCrCHdi0Hb3Q+RwBQ7sZhWs4XM/HDDu
         epFg==
X-Gm-Message-State: APjAAAW5Gw0Tsoz5TkiGza0JpcfWGgGUyV5/ndxcdScnQ1YDL83lCLiD
        3V3NCjdwLlmcKFSRkBuCNFduSg==
X-Google-Smtp-Source: APXvYqzMltOxjDFTZz0aISvCEPIjrr/aWK4KPPg5Rh3wcZVfSUAn0hFXxfBWGM5eTwW2w3A8GqAKDA==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr13205891wrw.391.1580492459005;
        Fri, 31 Jan 2020 09:40:59 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id 21sm11359594wmo.8.2020.01.31.09.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 09:40:58 -0800 (PST)
Date:   Fri, 31 Jan 2020 17:40:55 +0000
From:   Quentin Perret <qperret@google.com>
To:     Matthias Maennich <maennich@google.com>
Cc:     masahiroy@kernel.org, nico@fluxnic.net,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kernel-team@android.com, jeyu@kernel.org
Subject: Re: [PATCH v2] kbuild: allow symbol whitelisting with
 TRIM_UNUSED_KSYMS
Message-ID: <20200131174055.GA8425@google.com>
References: <20200129181541.105335-1-qperret@google.com>
 <20200131131508.GH102066@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131131508.GH102066@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 Jan 2020 at 13:15:08 (+0000), 'Matthias Maennich' via kernel-team wrote:
> On Wed, Jan 29, 2020 at 06:15:41PM +0000, Quentin Perret wrote:
> > diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
> > index a904bf1f5e67..8e1b7f70e800 100755
> > --- a/scripts/adjust_autoksyms.sh
> > +++ b/scripts/adjust_autoksyms.sh
> > @@ -48,6 +48,7 @@ cat > "$new_ksyms_file" << EOT
> > EOT
> > sed 's/ko$/mod/' modules.order |
> > xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
> > +cat - "${CONFIG_UNUSED_KSYMS_WHITELIST:-/dev/null}" |
> 
> This handles absolute paths very well. I wonder whether we can make this
> more useful for folks that want to maintain such a whitelist in their
> copy of the tree. Lets say, I have in my sources
> arch/x86/configs/x86_64_symbol_whitelist and in my config I have
> CONFIG_UNUSED_KSYMS_WHITELIST="arch/x86/configs/x86_64_symbol_whitelist".
> 
> If I see it correctly, UNUSED_KSYMS_WHITELIST is currently either an
> absolute path or a relative path to the current build directory. I would
> prefer if relative paths would be relative to the source directory to
> support the above use case. (Note, that scenario above works if I build
> directly in the sources, but fails if I build O=/somewhere/else.)

Right, that is an interesting use case. I suppose something like the
below should work (with appropriate documentation of the config option).

---8<---
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index 8e1b7f70e800..d37803fd75ce 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -38,6 +38,12 @@ esac
 # We need access to CONFIG_ symbols
 . include/config/auto.conf
 
+ksym_wl="${CONFIG_UNUSED_KSYMS_WHITELIST:-/dev/null}"
+# If the path is relative, it must be relative to the source tree
+if [ "$ksym_wl" == "${ksym_wl#/}" ]; then
+       ksym_wl="$abs_srctree/$ksym_wl"
+fi
+
 # Generate a new ksym list file with symbols needed by the current
 # set of modules.
 cat > "$new_ksyms_file" << EOT
@@ -48,7 +54,7 @@ cat > "$new_ksyms_file" << EOT
 EOT
 sed 's/ko$/mod/' modules.order |
 xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
-cat - "${CONFIG_UNUSED_KSYMS_WHITELIST:-/dev/null}" |
+cat - "$ksym_wl" |
 sort -u |
 sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$new_ksyms_file"
--->8---

Thoughts ?

Thanks,
Quentin
