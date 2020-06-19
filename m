Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4467DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1362D208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7Oh89HC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbgFSOUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732461AbgFSOUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:20:25 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECA8C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:20:24 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g1so7748389edv.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a8ouono3/9wkmoHXFRDJLystsfW27Vj/z6In1ogYbNs=;
        b=G7Oh89HCJu6Kc2Am/wkdOFGgT9s4pF/E52Va+mrxV1I65mvhK8euaOFBgk0WufM5+f
         rrE0Tk0ZJYxv/Ld9EvyLxdqqTZLvUYskhLbQV+sjPnsEesmKUK9+ar/txOM9d6tBTYho
         /x9rjV9WvUohqpqFyrrVmClgXxnjc08t7zuYsw9h93vNwzSfoyFNxFQhnyzDMw9dZWvp
         ZKxiy981Ki8/KwhQQPUnrISCcbRtLEMXV0VVmgWQV1vg3AyBDzKHQyy80a2f43OHGeLb
         KFscw2zeP6EoARCNYEmPmtdl6IWS2WZyCD8eB8Obg0FGE5FtFWtceeU3dosNvLSxOcp7
         0RFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a8ouono3/9wkmoHXFRDJLystsfW27Vj/z6In1ogYbNs=;
        b=Z8uCP8TOAP/UTj3v/dxzCwmlgM+vxLn761t9hkx6a3i/FObvi54h4fMxzafFlIhKGQ
         M9+5vtpfY0vqI1SCIvrb/JjOh/Dhu85jmwF883frYaN/XoZYgy3Jv48nq8b/pdKDcL3G
         v2JSNS8/h5mmQjqTy8JrCc7VJ9rKMg1umgC9qa5F/Ingm3PDLu4Ilucbi2+VnZ83VkUY
         v1sGNOZOPel3aoG+SE625FaXjwDo4ScKSCc+E70cX8S+OvCdaZ4cyNpcUtKYZVlX24H5
         G0pCy5N3YELy1FPdPjRdnnhrQvgEbdRN2VPvQJjAllVx5LCMGUOoean1OorFCkuVieim
         qV7A==
X-Gm-Message-State: AOAM532q6u5XP4fw92xdxA2OIvybAbmcVv9y62hSbRqb02c9vG62EMI3
        2cM1oIIvz/ZJUfjemF95FdzUozCK
X-Google-Smtp-Source: ABdhPJzjcApG6GRvuJP0gB/OVsBNly4jMwJiRltqZIVwfUONnANMSOcVRDlPUkYTHFVl92fqnLUMnw==
X-Received: by 2002:a05:6402:128f:: with SMTP id w15mr3700308edv.240.1592576423454;
        Fri, 19 Jun 2020 07:20:23 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:904f:be8d:1d92:9974])
        by smtp.gmail.com with ESMTPSA id ox27sm4871450ejb.101.2020.06.19.07.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 07:20:22 -0700 (PDT)
Date:   Fri, 19 Jun 2020 16:20:22 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sparse: use identifiers to define address spaces
Message-ID: <20200619142022.rvv7lbuboeehdxqi@ltop.local>
References: <20200617220226.88948-1-luc.vanoostenryck@gmail.com>
 <CANiq72nNQ+11ch7sRjLLc33s_OkftuOqgGkCDggq88tbJtdPNQ@mail.gmail.com>
 <20200618050249.lqwznznltm3lcykr@ltop.local>
 <CAMuHMdWQsirja-h3wBcZezk+H2Q_HShhAks8Hc8ps5fTAp=ObQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWQsirja-h3wBcZezk+H2Q_HShhAks8Hc8ps5fTAp=ObQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 10:07:34AM +0200, Geert Uytterhoeven wrote:
> 
> Indeed. It looks like this whole list is completely unsorted, and was created
> by appending new definitions at the bottom.
> So perhaps all the address_space ones should be grouped together?

Hi Geert & Miguel,

Yes, some cleanup is welcome, I think.
I'll send this in a separate patch soon.

Thanks for reporting,
-- Luc
