Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEAFC54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 07:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5D92137B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 07:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc7oqcRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgEJHVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 03:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgEJHVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 03:21:10 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520CFC061A0C;
        Sun, 10 May 2020 00:21:09 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mq3so6241337pjb.1;
        Sun, 10 May 2020 00:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lsg0wKVZx0sdTDbSZQB7tVXAbK/t5VVMEHG7qq+VpiI=;
        b=kc7oqcRe7Ib1fuv0/jIHCWkmBFAPgwR8IxmmJWcwgBaaKdHVTDNQtOhGhINO5lwUW+
         5BVlDNAF2XYO0Qvxp+aasg8UTX2hafiVg+kedxzY+PyQEwwy1wWcBYNHEFiQbSmzxThy
         5vkAuDlAe0BCiZ7fHCDrMoqom4oZ3cpN/Liso7zkqTyJmVxcBCNWTLPCmFBHZSFKluYt
         Jw0iTUYq3B6jrMTolySUHo9j0Mbxnt18HKpNRtLT7ii7OQOvkqjJIJX2EMlftv4uM/tA
         A8/AVFBmm6K0AYc0XUq2ki5Lupc1A/NF0SI4GqCHZHFY8g8e0BoyTsu6+K3uqvHj+Q/y
         Xrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lsg0wKVZx0sdTDbSZQB7tVXAbK/t5VVMEHG7qq+VpiI=;
        b=O+Ph0/k2jJa1yjnJ77dJvPgl/vDN8CUCLfz304qTcjHJhVZzlENIEOU10mkY/2HHqS
         Z0IlllJE46lGGzWKwIwW4l/CSQ2XXjJGMgpr58TbzPMONzCQUkqmI4Yni+surc09IoXG
         +Jad6/Bvez8N5xnGhULCvcoTFBN7haclVm56COc0PVZ9iE+wxLoIb87TIlfWxh8ZVzwa
         hXYtyTCRhn/bBXynSJCBG4m9mMNq1h5QyeJBKYOJp240cfaZoht01CiTj2Rj7PtsvEOk
         RErC3nUdBXMB06Ct4sjlSkIW/7gRP+aKf6iEv+QtAZ/bqokjlWflE7qCZw2lndhXLlNB
         dbKQ==
X-Gm-Message-State: AGi0PuZYqO8uFOlVir0rEWc7rt9WH0FxrMtwNScmeNt2WbuXilY/lw/Y
        opgPQLpGsZI51n4GGE789kY=
X-Google-Smtp-Source: APiQypLYTRNgwsLhitgm/wKpdLrUdj0w/Sg7F9CTRdkUE7qOtaUEYIivvO7e+aLSCyxwPqVRw2gVWg==
X-Received: by 2002:a17:902:5a84:: with SMTP id r4mr9432386pli.314.1589095268666;
        Sun, 10 May 2020 00:21:08 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id dw12sm6533425pjb.31.2020.05.10.00.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 00:21:08 -0700 (PDT)
Subject: [PATCH 0/3] tools/memory-model, Documentation/litmus-test: Sort out
 location of litmus test and README
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, vpillai@digitalocean.com,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>, linux-doc@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
Date:   Sun, 10 May 2020 16:21:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 May 2020 12:43:30 +0900, Akira Yokosawa wrote:
> Hi Joel,
> 
> Sorry for the late response but I've noticed some glitches.
>  
> On Sun, 22 Mar 2020 21:57:32 -0400, Joel Fernandes (Google) wrote:
>> Move MP+onceassign+derefonce to the new Documentation/litmus-tests/rcu/
>> directory.
> 
> MP+onceassign+derefonce.litmus is called out in
> tools/memory-model/Documentation/recipes.txt as a representative example
> of RCU related litmus test.
> 
> So I think it should be kept under tools/memory-model/litmus-tests.
> 
> Further RCU-related litmus tests can be added under Documentation/litmus-tests/.
> 
> IIUC, this change is not picked up by tip tree yet. So we have time to respin
> the series targeting v5.9.
> 
>>
>> More RCU-related litmus tests would be added here.
>>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>
>> ---
>> Cc: vpillai@digitalocean.com
>>
>>  Documentation/litmus-tests/README                        | 9 +++++++++
> 
> Please note that later patches to add atomic litmus tests under
> Documentation/litmus-tests/ by Boqun put README as
> Documentation/litums-tests/atomic/README.
> 
> This patch's location of RCU's README as Documentation/litmus-tests/README
> looks asymmetric to me.
> 
> I'm OK with either merging atomic's README with the top-level one or
> moving RCU's README to under Documentation/litmus-tests/rcu.
> 
> Joel, Boqum, can you sort out the location of README?

So something like this?

Patch 1/3 is an independent typo fix in recipes.txt.
Patch 2/3 reverts the MP+onceassign+derefonce relocation.
Patch 3/3 merges atomic's README into the top-level one.

This is relative to -rcu's lkmm branch.

Thoughts?

        Thanks, Akira
--
Akira Yokosawa (3):
  tools/memory-model: Fix reference to litmus test in recipes.txt
  Revert "Documentation: LKMM: Move MP+onceassign+derefonce to new
    litmus-tests/rcu/"
  Documentation/litmus-tests: Merge atomic's README into top-level one

 Documentation/litmus-tests/README             | 22 ++++++++++++++++---
 Documentation/litmus-tests/atomic/README      | 16 --------------
 tools/memory-model/Documentation/recipes.txt  |  2 +-
 .../MP+onceassign+derefonce.litmus            |  0
 tools/memory-model/litmus-tests/README        |  3 +++
 5 files changed, 23 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/litmus-tests/atomic/README
 rename {Documentation/litmus-tests/rcu => tools/memory-model/litmus-tests}/MP+onceassign+derefonce.litmus (100%)

-- 
2.17.1


