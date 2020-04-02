Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79475C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4B22078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="kimZVNAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387672AbgDBIHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:07:32 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40244 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387476AbgDBIHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:07:32 -0400
Received: by mail-wr1-f48.google.com with SMTP id s8so873244wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 01:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rFtafj8G3p6uylJpT3LxPW3DfRAp8Fyv/LimRAr9TMk=;
        b=kimZVNAGXwCuOkN4OBZz/FkvFPotAj/bw5l9yyVqCbO7OEmZD14W1Sds/6Uvlt51O9
         OOYrx77C6acyKzgxtKVjIk3UxiPp7XbIB8slejG33+0PFkERjBRmRHbt6/1gcpsh3OHK
         g5s+vK8ybk62dtiDNDWcpJDrwTFU059BdQq8IlYHxXo3SrKzD2xI2MSFgRNay2KwtPXU
         l7IMGGVoYJFdrL1vqRI98E3fSSae6etQ1hs115INSsupTqU8HYXbTXhTKzuiJ90GjvJb
         f+wtLV9OaGAu1gd71W4NoTY0n817N60y6Lh/pZ3TFTkPGoNLSRTnI5EA9Q5gcUokj/Vi
         QVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rFtafj8G3p6uylJpT3LxPW3DfRAp8Fyv/LimRAr9TMk=;
        b=UJWRByJCmWBVag3ZilSV0iZ60W/RBa/i5H2D6RWBAnlMga7LL+2oG00YRH1d9cp3e6
         MRbfpE4XldBc5p3O7Hg9UXsSEEqfwovb/twHUM2wblX5bMS+FFM6SjO9cyja94KdAIuk
         8lGA7xNng9avl1mqghv2f7vjFLGR7Do01lWfMVKO/bS0RlR0rjCGc7qbf64243Sp5FY6
         9lr9G8zewEiwHe8MNLUvqpZSloy/nuNurYZBZp9lWfqQ6sbnXQXXRHFM2hMf8/kt6Y8P
         IOzQNSjiGd8BUVmy/0qbEjzx9woqvUNu/NfAmHEqDsSxNDvrN5XLYNkSIIIbI37N5mT7
         al7A==
X-Gm-Message-State: AGi0PuaGDBBrFyNe59K3Zf2gOTaxblnZGLRpxYKbVjzg8v+7pKmKWLCY
        Y7jePvPSlghl76CxI+UrtEwMVQ==
X-Google-Smtp-Source: APiQypLeuzM1SXog1adVslcN8rAHhURouHDugYLsv+YoexQ0M9ZMz7jTgOOCL6PkdU8DrNcEtc20+Q==
X-Received: by 2002:a5d:4c48:: with SMTP id n8mr2154904wrt.414.1585814850456;
        Thu, 02 Apr 2020 01:07:30 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([79.132.236.184])
        by smtp.gmail.com with ESMTPSA id h132sm6489763wmf.18.2020.04.02.01.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 01:07:29 -0700 (PDT)
Subject: Re: [MPTCP] [selftests] eedbc68532:
 kernel-selftests.net/mptcp.pm_netlink.sh.fail
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        mptcp@lists.01.org
References: <20200402074609.GH8179@shao2-debian>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <7a1b24ac-73f2-bac1-f450-d8e6c802c0ce@tessares.net>
Date:   Thu, 2 Apr 2020 10:07:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402074609.GH8179@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you for the automatic bug report!

On 02/04/2020 09:46, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: eedbc685321b38fea58a14c9fbd258c4b2c2747c ("selftests: add PM netlink functional tests")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

(...)

> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

(...)

> # selftests: net/mptcp: pm_netlink.sh
> # defaults addr list                                 [ OK ]
> # defaults limits                                    [ OK ]
> # simple add/get addr                                [ OK ]
> # dump addrs                                         [FAIL] expected 'id 1 flags  10.0.1.1
> # id 2 flags subflow dev lo 10.0.1.2
> # id 3 flags signal,backup 10.0.1.3 ' got 'id 1 flags  10.0.1.1

(...)

> not ok 2 selftests: net/mptcp: pm_netlink.sh # exit=1

This issue has already been fixed:

   3aeaaa59fd69 (selftests:mptcp: fix failure due to whitespace damage)

This commit -- making both Git AM and selftests happy :) -- has been 
quickly applied by David (thank you for that!) and it is already in 
Linus tree.

Cheers,
Matt
-- 
Matthieu Baerts | R&D Engineer
matthieu.baerts@tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
