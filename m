Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E8FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EEF20757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5Xv+V7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgC3NpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:45:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38063 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgC3NpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:45:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id f6so15369763wmj.3;
        Mon, 30 Mar 2020 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xw3Aeu1v5BI29K5eso3Lkg3AloauIh2uWmXpI+AmhiY=;
        b=c5Xv+V7f4qLn1n9Bq/YdH7JHHjyZMNJ4UExOpMjDBnUH2JEUkcQKaXsUJL1YX2iNFA
         vuFrxH2WBmy9eaD/xd2Ie8k/+mg9jY1VnjGVBnMBLMZuPTTUP+1wd/Wd49n0YmIzBju2
         11vhKs/MXreMIfK12gtAojNGR7B5Y/JjA4nnS/HfNmYeMFjaFvjULXazXFtemU8MJ/AC
         aOBx0GOQ569L5eNKdBu7NfPiX4QkhmnpXhKD1gpQZY3X7re0gRK+u3glHXyMwwZph57J
         VzMMMLg9RNJNZFTbz547kaY+9/tW2jVX8vbP6uMCKH1Gq9wxkdJ5DkVyGTZkLQ4p6rls
         EVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xw3Aeu1v5BI29K5eso3Lkg3AloauIh2uWmXpI+AmhiY=;
        b=rMAZMv9SqndA0PjPWv0/SLpB16UxhITJ5wfMbThaVS1rprDY0MZj/e0zqQOzi7lHc4
         C6/kKRvhhGE9u2QxAfZOBSFubbM4ClNXzo7tSNXz3bUzrWIOjHZCBWb9VMAj8TLlunfz
         IaaX6PwbJyUAv5gnToAJu4aE7698V/j/RU5gJIV8jsLDax83Zk5i9mZFCZlD1HQu+yCE
         H4VeAAYfRgmbBEanLtifKT9qcFik4cDPG0cu2OjNicIk8gnyusoE+LfZpzhveoJZr3H0
         ZWvBf8wO1oaTy8Fb5pqaaT3OKBLFnBhkVRUF4foCvmv0kN0HRFVFvqwWjBDDakFisen0
         HA9g==
X-Gm-Message-State: ANhLgQ32Nt9OHbtWHlqevyuUfOf6bwSafNZdC2Jzc411jNyOCwfiVTm/
        BaT2p1aTO4vofgSe2AnZEMNDyobc
X-Google-Smtp-Source: ADFU+vv8SvRbzMNTYwA8kUYDxBYyIcxNFxjoyBcIW9A6RuX8UUP0DLieZPqM9liKJKUtx8/eHfIFkw==
X-Received: by 2002:a1c:bd0b:: with SMTP id n11mr464190wmf.178.1585575920714;
        Mon, 30 Mar 2020 06:45:20 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id q8sm23440249wrc.8.2020.03.30.06.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 06:45:20 -0700 (PDT)
Date:   Mon, 30 Mar 2020 13:45:19 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] XArray: internal node is a xa_node when it is bigger
 than XA_ZERO_ENTRY
Message-ID: <20200330134519.ykdtqwqxjazqy3jm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-7-richard.weiyang@gmail.com>
 <20200330125006.GZ22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330125006.GZ22483@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 05:50:06AM -0700, Matthew Wilcox wrote:
>On Mon, Mar 30, 2020 at 12:36:40PM +0000, Wei Yang wrote:
>> As the comment mentioned, we reserved several ranges of internal node
>> for tree maintenance, 0-62, 256, 257. This means a node bigger than
>> XA_ZERO_ENTRY is a normal node.
>> 
>> The checked on XA_ZERO_ENTRY seems to be more meaningful.
>
>257-1023 are also reserved, they just aren't used yet.  XA_ZERO_ENTRY
>is not guaranteed to be the largest reserved entry.

Then why we choose 4096?

-- 
Wei Yang
Help you, Help me
