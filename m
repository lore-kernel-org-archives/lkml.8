Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF69AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C84206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mANY5A32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbgF3Jgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731994AbgF3Jgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:36:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1003C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 02:36:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o2so18924784wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 02:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=yaOhFBmIqdn8G4lrtwHvUko5nSvGDP5g5mqN3hIlOT0=;
        b=mANY5A32i8Xy+WIr5jslEb6KJMif7iF1qzxgC6tqzDIyhbXDlubrFkGRvv17KOz1vm
         DII2C2sjbT0SA5QtOWC3rikX6g0TIDVksXlE1WBmXoEp4WtXimS2XIj+vUQDKFCQ1OwC
         MoNz8JuOwgUmGPizW8OxgxTQcTmOKjJTQVd+q4vhbTE+4B6DCH58RLmW6IKe7DgMCgjv
         OsXXjHFMAtwhR978XaZ0zoSIJGejy3aEkjbve+jCAezLx7GRLGipnVznG3yp4dlxWUup
         GnB0P8WAGtunjHN9mR1OE6rxRa0jgcsUGuRObl8rCkz7RkXWovMOjDKXPf1NCvUP5Ema
         eP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=yaOhFBmIqdn8G4lrtwHvUko5nSvGDP5g5mqN3hIlOT0=;
        b=TVhnCORfRaRGjePo8EvKh6S+5i+pt3aAIFypdXy1vDUHj9Oj9Lqql5pXQnDbWLcU96
         l9uaKOVtFqxRLS3vQL5xmkuuhkd2BPvYMvWxmbujHT0V4iFePqYfOiQFCP+UqJnioeCz
         uXF3Uqdz87FqhyD5dJsLVjOyBwI3L8Z2Q1BfU2Atstxl8523+ZPuNwSKIJJIjKLrFeoF
         5CNPplyKr9FXqZNDErbqQuSIOXa7LtZgV6S3QdQ4YnKburEvMtruBcx2mSi+LHe9jTel
         Uci4ldVMwIUciXQU29tBGT7eiG3wiRgzz1lDIkrixiGjpyxjqhY68U8D2HhOM/693LoC
         zGQg==
X-Gm-Message-State: AOAM530/M+Asc3FWjmqb/qwU6e/B8OyAChW6/oR5FwdTQwKPhstge2FZ
        y/xelacsQPuZM4Rhcu96TP5lsQ==
X-Google-Smtp-Source: ABdhPJwHunjXx/RLUoEt7TrvTZZBpJuDl+cFP0Xg4HKFJn9lm5Uol4Z2jknkTbH7j0IqbX1N7+ZDxQ==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr12380909wmb.113.1593509802412;
        Tue, 30 Jun 2020 02:36:42 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id j41sm3102267wre.12.2020.06.30.02.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 02:36:41 -0700 (PDT)
Date:   Tue, 30 Jun 2020 10:36:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: scripts/kernel-doc update
Message-ID: <20200630093640.GK1179328@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Jon, et al.,

Would someone be kind enough to update scripts/kernel-doc to elegantly
handle complex bitmap expressions in structures please?  Presently
only simple syntax is handled.  Something like:

struct foo {
       u8 arg : 10;
};

However, the bitmap is sometimes derived from some pre-processed
define or calculated.  Similar to the following examples.

Example 1:
---------

  File: drivers/misc/vmw_balloon.c

  struct vmballoon_batch_entry {
          u64 status : 5;
          u64 reserved : PAGE_SHIFT - 5;
          u64 pfn : 52;
  } __packed;

Example 2:
---------

  File: include/math-emu/single.h
  
  union _FP_UNION_S
  {
    float flt;
    struct {
  #if __BYTE_ORDER == __BIG_ENDIAN
      unsigned sign : 1;
      unsigned exp  : _FP_EXPBITS_S;
      unsigned frac : _FP_FRACBITS_S - (_FP_IMPLBIT_S != 0);
  #else
      unsigned frac : _FP_FRACBITS_S - (_FP_IMPLBIT_S != 0);
      unsigned exp  : _FP_EXPBITS_S;
      unsigned sign : 1;
  #endif
    } bits __attribute__((packed));
  };

The first example causes this warning:

 drivers/misc/vmw_balloon.c:262: warning: Function parameter or member '5' not described in 'vmballoon_batch_entry'

The second doesn't use kerneldoc, but is an example of a complex, but
totally possible/legitimate use-case.

Would it be feasible to make to make the regex which handles bitmaps
greedy up until the ';'?  Or perhaps someone can come up with
something more refined that would solve the problem.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
