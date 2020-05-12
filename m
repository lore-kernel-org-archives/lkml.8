Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE5DC2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5699A20769
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="carC9FJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbgELVeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728313AbgELVeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:34:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEDBC061A0C;
        Tue, 12 May 2020 14:34:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f15so5961715plr.3;
        Tue, 12 May 2020 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kxQHTgfWb1TWEniSfiRONfdoQ6CTk9tziVfHxZmBMVA=;
        b=carC9FJNskNYTWyopK2lAEOe6wuju8Ynu+HMmPB68lQDw8h2VhId8tzE+6xbqD7aH9
         f+Th9ugkoPAcqQ25WrWHWdwMqx6RLkLTz7tgIDosU4bFxe3yeZO5wh0hMZgae3zfA9gB
         j5MECJcO8GzUt/xMNp9xQqNpt9y/t11eImiUoQnKrfRzXDlNZ2A/8bAQwNj5ZOcvzXDO
         0CyPBGc+V1ScGeP4+z8wfOg/WM1BYmq91DeRXgz2DRB4N/PrEdSSwBka+oN7O74PUX26
         dwW+lCvAm6zi7QrImVQEhd8MOUbFbj5Q5VjFdKq4vCkYVmOdIKJUBSaIV4oEn5HJH+WT
         tbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kxQHTgfWb1TWEniSfiRONfdoQ6CTk9tziVfHxZmBMVA=;
        b=erXwESUAgPXJGH9JQ5fiPpALmoQ8BwHVuYJ7b0OuzYRO8HDuNw02GpiihgjD8L2Ef2
         yasMgjmQMr9IcorNSbDuZpQdglvaOCuvwPIp07Ql2hjNoY6KwjHO9znT75iXvJ7+BlUI
         7E1KMOGc+VvVGWbnvYiiM//kSvgOxfqgoc1h8TN9+ezKa2gxrvbz3V44JyWO/H/s5cik
         zFDuJ4Xln4w9XmyW/PN1/xhP606MqrCKup+7d6ft26An6FtjfWGuKCpPv/RMKF4IKo4Z
         5G8Bc1t3Ol5lvWK7UyPByJO0G+N1m57/am3v2w8J8wxmWOcHclRanQejRpffxuVbzycO
         yHmg==
X-Gm-Message-State: AGi0PuZYSfFiUPr7QYk8GmltagS7kg+JC9DKcNr3xza3bU5IV8WyuNIE
        zJ1rKXyBXrKJwawij63Oin8=
X-Google-Smtp-Source: APiQypIVnRNV204nLNeiwIYtBPN2sIp01hfrI6It+YHh9Qy/rFv1irHRlv83+luiNSUuEuynl4ctfA==
X-Received: by 2002:a17:902:7d85:: with SMTP id a5mr22399336plm.106.1589319241873;
        Tue, 12 May 2020 14:34:01 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b11sm11199946pgq.50.2020.05.12.14.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 14:34:01 -0700 (PDT)
Subject: [PATCH RESEND 0/4] tools/memory-model, Documentation/litmus-test:
 Sort out, location of litmus test and README
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
 <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
 <20200512163022.GI2869@paulmck-ThinkPad-P72>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <09a8f418-0a46-87ea-dbdb-a43efc66476c@gmail.com>
Date:   Wed, 13 May 2020 06:33:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512163022.GI2869@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, 12 May 2020 09:30:22 -0700, Paul E. McKenney wrote:

> Could one of you please send a patch series and instructions, which I
> -think- will be of the form:
>
> o	Revert a5cca3485d92 ("Documentation: LKMM: Move
> 	MP+onceassign+derefonce to new litmus-tests/rcu/")
> 
> o	Apply a series of patches.

Here you are!

Note: For 1/4 -- 3/4, Added Andrea's and Joel's Acked-by tags.

       Thanks, Akira
--
Akira Yokosawa (3):
  tools/memory-model: Fix reference to litmus test in recipes.txt
  Revert "Documentation: LKMM: Move MP+onceassign+derefonce to new
    litmus-tests/rcu/"
  Documentation/litmus-tests: Merge atomic's README into top-level one

Joel Fernandes (Google) (1):
  docs: litmus-tests: Clarify about the RCU pre-initialization test

 Documentation/litmus-tests/README             | 24 +++++++++++++++++--
 Documentation/litmus-tests/atomic/README      | 16 -------------
 tools/memory-model/Documentation/recipes.txt  |  2 +-
 .../MP+onceassign+derefonce.litmus            |  0
 tools/memory-model/litmus-tests/README        |  3 +++
 5 files changed, 26 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/litmus-tests/atomic/README
 rename {Documentation/litmus-tests/rcu => tools/memory-model/litmus-tests}/MP+onceassign+derefonce.litmus (100%)

-- 
2.17.1


