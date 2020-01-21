Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A565C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390732253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXpsgVKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgAUPBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:01:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40435 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAUPBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:01:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id u1so3110763ljk.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6DzX/6x6yVWrZI+wZeTseenMuBzS/NjeUu7BzygEE/8=;
        b=VXpsgVKPZT2JseU60NlzzxmyR0H/zObzdwyLNv/QIz4zkUjpRDCE8SR6j6FbvLK5z8
         ZWY49jzxWCJmA8GXu37WBns/SicdHScCsSN1heOC1D9OBWEfiVFDnDk2/pU2QzLoZskD
         2ZZLUQISHxgpN6WGIKYj9LRIgHjzuTdb+hYs4OWkJ8yPVKUY37wuPMPMFUOrY99aPwlz
         71EbJ7PqzVw9yKkAKSjv9fWWIIaTvz/BjVfY2rMyiq7o3q8kIO2BCZLcFYt31kfaUa47
         RHwRXND2EfZmq0J30ORhF3tEmQEE/rRkJ422WFKmwRo9uTLH2weztw52Yc05j5GC98Ha
         ZLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6DzX/6x6yVWrZI+wZeTseenMuBzS/NjeUu7BzygEE/8=;
        b=fHy6vybwr2gKojOsYO4zhgGTC6EQNIM7a47wfdtTukoKe/uMoNWFdkX/wZgcTsPj8L
         8S9JXN4Ytg1g/0p+BwN0ilx7QZTSz7kDvl9yaaNxINXg5zMYsfDkyIZk7QQ3ximyjg0i
         VnjimbEM+z+4Z50/B1jTazAd89PNC8AX83JugC7Qw9RYZM0bZwS7/gb+cLsEc88S13Oi
         okAFXB23Cd1V7rhTv5jR00hcn40jxyMXn7zWRmnAMnYymrarDuCkelAhvu4ilJnZFt9W
         rENPgDCM8qsBslN9n59eSKOSsh9Lb/JO5yLAMD9qitRz5FNvw/bzArIQHzILd+A3Pu3B
         qZVA==
X-Gm-Message-State: APjAAAVnwiiUwHNzSi3gvBwGogu3/5MTS6RF/MHCyKAc9zaS+ht0o7RF
        03nAM6tpJpWeGoxMyUccjPI=
X-Google-Smtp-Source: APXvYqywmPmOG/hPLkfshGTD1vwb3xA4RXYEmHY0sxZvpPYB6WqmCUKlDLk5Z/3qTiWLaLK9+WHAOA==
X-Received: by 2002:a2e:9a01:: with SMTP id o1mr16888697lji.247.1579618860344;
        Tue, 21 Jan 2020 07:01:00 -0800 (PST)
Received: from localhost.localdomain (h-88-110.A230.priv.bahnhof.se. [212.85.88.110])
        by smtp.gmail.com with ESMTPSA id t20sm18441519ljk.87.2020.01.21.07.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 07:00:59 -0800 (PST)
From:   Mikael Magnusson <mikachu@gmail.com>
To:     gustavo@embeddedor.com
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: n_hdlc: Use flexible-array member
Date:   Tue, 21 Jan 2020 16:00:53 +0100
Message-Id: <20200121150053.31457-1-mikachu@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <957960eb-118f-21c7-8901-50f54d65d7cb@embeddedor.com>
References: <957960eb-118f-21c7-8901-50f54d65d7cb@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo Silva wrote:
> On 1/20/20 23:54, Jiri Slaby wrote:
>> On 21. 01. 20, 0:45, Gustavo A. R. Silva wrote:
>>> diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
>>> index 98361acd3053..b5499ca8757e 100644
>>> --- a/drivers/tty/n_hdlc.c
>>> +++ b/drivers/tty/n_hdlc.c
>>> @@ -115,7 +115,7 @@
>>>  struct n_hdlc_buf {
>>>    struct list_head  list_item;
>>>    int     count;
>>> -  char      buf[1];
>>> +  char      buf[];
>>>  };
>>>  
>>>  #define N_HDLC_BUF_SIZE (sizeof(struct n_hdlc_buf) + maxframe)
>> 
>> Have you checked, that you don't have to "+ 1" here now?
>> 
>
> Yep. That's not necessary.
>
> _In terms of memory allocation_, zero-length/one-element arrays and flexible-array
> members work exactly the same way.

This is not true, but maybe it's still not necessary in this particular code, I didn't examine it.

Consider the following:
#include <stdio.h>

struct flex {
  int count;
  char buf[PRE];
  char flex[];
};

struct one {
  int count;
  char buf[PRE];
  char one[1];
};

void main() {
  printf("%ld %ld\n", sizeof(struct flex), sizeof(struct one));
}

--snip--

% gcc -o siz siz.c -std=c99 -DPRE=7 && ./siz
12 12
% gcc -o siz siz.c -std=c99 -DPRE=8 && ./siz
12 16

Since all the preceding stuff in the struct in the patch is aligned, then the [1] will definitely add something to the sizeof count.

-- 
Mikael Magnusson
