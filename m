Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93637C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 18:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74BD120836
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 18:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfLflQyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgD3S5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 14:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD3S5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 14:57:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85457C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:57:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r26so3302948wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d5WxWhtGo9e2cw/8suqpVIB4+YEef9w62JZ0kEYHubo=;
        b=nfLflQyW8kj3CShI0XY4Vf6gRlgHFhTVQZw/GdD/zV4jALyGUkiWfG1+YbmI/MdYAj
         bdgTZPpCZ7Uf3+4PI7o2+IBAYzeEoV2BgNFA/RJ5ZJJkLTEnSmU8eG+X+oGMBE9ASWq9
         FlAdajBRHQVg1AZ3Ljwgtn8mCP8u3g8A/uGbua+pVlGqTbJdH+KsVd6ioM/C7DLFfrdR
         KJv+BsPm8MJOEf0OU/7N8vwe34xLtNw38tm8MlwiUDdAgkIEqasbbBr+Bv2uA/8MaTY6
         rN2xSH/xxF9Rupsf5ruVst0HeoT4VWff/Z2RxG0CBHKc/8ClZusJAiOUrSSWH7m83gcp
         p85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d5WxWhtGo9e2cw/8suqpVIB4+YEef9w62JZ0kEYHubo=;
        b=BJdF6kFZw7r/8gsv7LZ32l9xxhGN8cJ+564v5ZgynLA81VYMun5TV8+/W169hPi7m5
         jJTPUEz4MTplpkNtRS/O5psF3U/Uy3khPFcyi0Q+iicrBX+bAi66ROJ8hUBTKcAhR1Ad
         uN2rx4c4T4uRWclBy5iI85OE+cjhpuj/1OwKppo5U0LJpPB8ZjRnqTR8G9TGzUGQlKJ6
         I8pji5sEIWgfwm2jHegaoa5dF03saB3l/jMPSS9OjNrkipFSGUFsKE3FsZ21ds6LUABY
         VHV8Gat10gCJuEnwjmgRet0LLxHrhBPI/5XlHtz1/PNdOytiq+dFCb3BsyORHvSj/stG
         xryg==
X-Gm-Message-State: AGi0Pubv4Z9KmfF3s/h4ZGLHCmigLl0BmqB7ipgYv1wUXgyKaTowkh7k
        X0z76KwBUy+H1Tp28n08X5OnfQ==
X-Google-Smtp-Source: APiQypJv60KX28ucnsH13Cw7j+iU/N3+xGie9VPYRPXyvaTcmuL9pnj+qnn6cgfiQwc5zxsDYQrDUA==
X-Received: by 2002:a05:600c:20c:: with SMTP id 12mr4867772wmi.91.1588273067897;
        Thu, 30 Apr 2020 11:57:47 -0700 (PDT)
Received: from dbrazdil-macbookpro.roam.corp.google.com ([2a01:4b00:8523:2d03:d4b6:9828:8bd2:ce6f])
        by smtp.gmail.com with ESMTPSA id j10sm713583wmi.18.2020.04.30.11.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:57:46 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
X-Google-Original-From: David Brazdil <dbrazdil@dbrazdil-macbookpro.roam.corp.google.com>
Date:   Thu, 30 Apr 2020 19:57:45 +0100
To:     Marc Zyngier <maz@kernel.org>
Cc:     David Brazdil <dbrazdil@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] Split off nVHE hyp code
Message-ID: <20200430185745.rcsug4f55yh5jtyr@dbrazdil-macbookpro.roam.corp.google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
 <73efca41e7b955db4963ff182624107d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73efca41e7b955db4963ff182624107d@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marc,

> Do you have any figure on how much bigger the final kernel becomes once this
> is applied? I guess I can find out pretty easily, but this is the kind of
> thing
> that would be useful to make part of your cover letter.
Bloat-o-meter puts the diff at 21KB:
  add/remove: 152/45 grow/shrink: 10/32 up/down: 27882/-6240 (21642)
That said, the size of `Image` hasn't changed at all, not sure why that is.
The size of Image.gz has gone up by 10KB.

> 
> I'll try to review this shortly.
Cheers, no rush.

-David
