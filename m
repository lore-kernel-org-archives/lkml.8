Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9831CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8318D206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgFDRWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:22:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36120 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbgFDRWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:22:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id a25so8316545ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=r3pHeafroYjCOPxLj9S1OAEXhOignYglUX2vpauVcxc=;
        b=p0anhZF2iv4Ad8pZ7TdBVQFm1FU4L6LgCHGIgFZ8PRhfLujC8hpR06O+s0ggcFomzo
         oAvK2Al+L3UpgYtiv+n1PKLwOB3w2zV+goEDbBcQW97B/qVdJmIPM4q4vrN2eIMrSB8P
         dc2n9yJwqsf+kdH8rDK/6c9Iw84JzmaC2zXD3QSX9vSM9t50FxJRXJTFnpWnThPMxYpR
         99adMLZZV9iO6TfNJPfthfbK9O5eVHRUrYI8bn1//1AZM3Otv08BLitAoVT7v6aD173Z
         UtHMyaYCdCmPCiCBBhrlzgdqUvRRWCMUGSEZTxEn5PVSTORyWfpZ9aOwAcY5B02sVsFd
         yOPw==
X-Gm-Message-State: AOAM532GfRT18/aYuVTdMo8fiEPJY1zL/UdX2xvbzOMPX//Xb1scEny1
        OsmGkn4jMxYB9RPu6zr0uiJvRMcV
X-Google-Smtp-Source: ABdhPJzR3w6y4xwJqMya+Erw0kueGPzVAADeyCkwHAO0k8u5M8StttYUqCllr92usyxQaf8X6mSa0Q==
X-Received: by 2002:a2e:7303:: with SMTP id o3mr2845188ljc.100.1591291336083;
        Thu, 04 Jun 2020 10:22:16 -0700 (PDT)
Received: from [10.68.32.147] (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.gmail.com with ESMTPSA id 3sm57077lfq.55.2020.06.04.10.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 10:22:14 -0700 (PDT)
Reply-To: efremov@linux.com
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <20200604140805.111613-1-efremov@linux.com>
 <alpine.DEB.2.21.2006041614300.2577@hadrien>
 <a188acce-348b-b106-9180-708c3050ef8d@linux.com>
 <alpine.DEB.2.21.2006041749520.2577@hadrien>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [PATCH] coccinelle: api: add kzfree script
Message-ID: <65dee3e0-7df9-5b38-fe4c-5de3f70380a0@linux.com>
Date:   Thu, 4 Jun 2020 20:22:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006041749520.2577@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you send an example of some C code on which the result is not
> suitable?

I've updated the pattern to handle false positives:

@ifok@
position p;
expression *E;
@@

(
  if (...) {
    ...
    memset(E, 0, ...)@p;
    ...
  }
|
  if (...) {
    ...
  } else {
    ...
    memset(E, 0, ...)@p;
    ...
  }
)

// Ignore kzfree definition
// Ignore kasan test
@r depends on !patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c")@
expression *E;
position p != ifok.p;
@@

* memset(E, 0, ...)@p;
  ... when != E
      when != if (...) { ... E ... }
      when != for (...;...;...) { ... E ... }
      when != while (...) { ... E ... }
      when strict
* kfree(E);


Example of false positives:

void test_memset_under_if(void)
{
   char *p = malloc(10, GFP_KERNEL);
   if (p % 5) {
      p[5] = 1;
   } else {
      memset(p, 0, 10);
   }
   kfree(p);
}

void test_memset_under_if(void)
{
   int i;
   char *p = malloc(10, GFP_KERNEL);
   for (i = 0; i < 10; ++i) {
      memset(p, 0, 10);
   }
   kfree(p);
}

void test_E_in_if(void)
{
   char *p = malloc(10, GFP_KERNEL);
   memset(p, 0, 10); // when != E is not enough
   if (10) {        // when != if (...) { ... E ... } is required
      p[5] = 1;
   }
   kfree(p);
}

void test_E_in_for(void)
{
   char *p = malloc(10, GFP_KERNEL);
   memset(p, 0, 10);
   for(;;) {
      p[5] = 1;
   }
   kfree(p);
}

void test_E_in_while(void)
{
   char *p = malloc(10, GFP_KERNEL);
   memset(p, 0, 10);
   while(1) {
      p[6] = 2;
   }
   kfree(p);
}

void test_E_in_struct(void)
{
   struct t { int a[3]; };
   struct t *p = malloc(10 * sizeof(struct(struct t)), GFP_KERNEL);
   memset(p, 0, 10);
   for(;;) {
      if (1) {
        p->a[2] = 1; // I give up on this
        p->a[0] = 10;
      }
   }
   kfree(p);
}

After all it seems reasonable to me to add forall and memset_explicit rather
than handle all these false positives. Something like this for v2?

@r depends on !patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c") forall@
expression *E;
position p;
@@

* \(memset\|memset_explicit\)(E, 0, ...);
  ... when != E
* kfree(E)@p;

Do I need to add "when strict" with forall or it's already enabled in this case?
Do I need to enable forall for pathing "-/+"?

Thanks,
Denis
