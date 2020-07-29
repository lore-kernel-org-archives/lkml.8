Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1E2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0F62082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="d5pNoGKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgG2Sce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG2Scd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:32:33 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF2DC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:32:33 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o22so18157295qtt.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=sbuGzfAXEu90/mb1KxvRVFNTEav+wJBHiGDp7KYLn/o=;
        b=d5pNoGKhhZSJ1U2hnE2QgpyNRXyWdy5CzWssvK8e5m9UCWTFT3DivPdKlbrS8Lhroy
         Q+Ory2dwx+5FMcg7WGADmy37Sw80SSCn2qGAfb13yHemobrCV+gw8VUpmnCGBjL4n05s
         t9vW7n0M+ALckESz1KTapB8in/rEyUPPlhWZAQWW9L7UaLdOC/j006FGs35FQyfELq0l
         sNyJUc3f1oWkgh26+VHo9fdtS3+R0gHjhwfo7g1dxsI9NCuf7/+gW7AmKLSVcVYQVnkv
         wDCBysP/09LebzKqgezyGw9u5rd3sTnRHKdxfCgJxbKw+AikBNsNeN0ymqK+7U+NzQvO
         UW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=sbuGzfAXEu90/mb1KxvRVFNTEav+wJBHiGDp7KYLn/o=;
        b=OST6jUDnK20TkUKVemvZa08453UHOt4k0ieFbdCIKIW2TenWv8rlIuLss/1Mw3kPsb
         FxwwCLbAaabd53KlKS/2LuweFf+O86THgyB3xfAIG2VoYxZ3cWS92Ht+qdX03w59YAp8
         6YvIt4nm5wTH5/Ktbzzy/I7l7SlMcx50NDR1VAlUEJATINSgj1g87V2lu1RjrnfaMo9e
         vrWC8uvWChZS9WiSGQ0L/VOtuObd3Hf5nZSv9u2ndRMOsPCm4QuW9QPpOSgdxhP7KLGg
         6u7aCioiBdXziYPC38VPOvReQtnLh0/sW2ke7zY/7uAUUf3KqRsp89g+YMkELFoebgUv
         aP0A==
X-Gm-Message-State: AOAM5334BMP1YAJQOE+ThmDa33dmr0qAB4Tec6LCMWrW/Fea7irQVLRo
        CbuBayb2HkPFAa6khflixDZvYw==
X-Google-Smtp-Source: ABdhPJzHnA3jlgx2Rkac90wfpWBQn+sE/m+x3vbkFuM/Hnpj8NhLqOoQ2DkMPjs2yAkNTunRkmfKaQ==
X-Received: by 2002:ac8:478f:: with SMTP id k15mr32939604qtq.287.1596047552340;
        Wed, 29 Jul 2020 11:32:32 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::10a7? ([2620:10d:c091:480::1:2ed9])
        by smtp.gmail.com with ESMTPSA id l64sm2118053qkc.21.2020.07.29.11.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 11:32:31 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Subject: Inverted mount options completely broken (iversion,relatime)
Message-ID: <0b154b9b-728f-7d57-d4c5-ec25fc9dfdf3@toxicpanda.com>
Date:   Wed, 29 Jul 2020 14:32:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Eric reported a problem to me where we were clearing SB_I_VERSION on remount of 
a btrfs file system.  After digging through I discovered it's because we expect 
the proper flags that we want to be passed in via the mount() syscall, and 
because we didn't have "iversion" in our show_options entry the mount binary 
(form util-linux) wasn't setting MS_I_VERSION for the remount, and thus the VFS 
was clearing SB_I_VERSION from our s_flags.

No big deal, I'll fix show_mount.  Except Eric then noticed that mount -o 
noiversion didn't do anything, we still get iversion set.  That's because btrfs 
just defaults to having SB_I_VERSION set.  Furthermore -o noiversion doesn't get 
sent into mount, it's handled by the mount binary itself, and it does this by 
not having MS_I_VERSION set in the mount flags.

This happens as well for -o relatime, it's the default and so if you do mount -o 
norelatime it won't do anything, you still get relatime behavior.  The only time 
this changes is if you do mount -o remount,norelatime.

So my question is, what do we do here?  I know Christoph has the strong opinion 
that we just don't expose I_VERSION at all, which frankly I'm ok with.  However 
more what I'm asking is what do we do with these weird inverted flags that we 
all just kind of ignore on mount?  The current setup is just broken if we want 
to allow overriding the defaults at mount time.  Are we ok with it just being 
broken?  Are we ok with things like mount -o noiversion not working because the 
file system has decided that I_VERSION (or relatime) is the default, and we're 
going to ignore what the user asks for unless we're remounting?  Thanks,

Josef
