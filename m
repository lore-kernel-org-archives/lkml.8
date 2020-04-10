Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D49C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED34F206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eab4sb4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDJO3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:29:25 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33053 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgDJO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:29:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id v7so2300813qkc.0;
        Fri, 10 Apr 2020 07:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HqixeQ1c5wIdCqT4FMHLM5bXGTWlO9ooQXJCo53yiEM=;
        b=Eab4sb4ZAudIQsTkALPp5p1jys1KaiL7jTRT4r3XZqZTjZAIFjUnb/UMfs3HeKP+31
         QP2mvnFNZ6bmEnF9plK2utIhowz9L1KlKSHRLVkKVi+hN1k4fiVHpFRrXqz/V/XgWZK5
         Ulc8LGCb4Wv/r3dCvnr96WCNVUJznuF+666Q2PCkxSeiecOF9sLnGbnJWzBnBDIWrWtB
         Zg52gWNLvUOAoEeYZfCp0brdstwz7Xsjwk+6TMVglz12AU+qgDJSH3JqATHaBUhtbnOf
         5Ms6zkUYshCfcmzCGEW+xSEWD0ZwWWf323HVLaUjEJEE2fm+R/KwoKsZdkY0N70S0FOS
         WXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HqixeQ1c5wIdCqT4FMHLM5bXGTWlO9ooQXJCo53yiEM=;
        b=lr7mtWDMXrwgrqKkGl2PLJckNQSbXw34CwekyJaW19XsYh7um01UHakrf21Ccaf/l2
         TUGdRkO1SwN5ehUKHcb+PIx9bHlHTCmStDS58p/t0fpBROZVATLjK3/MBXgwiHFMVMO2
         yrMCo9ZoMFf4x6ojLQrAOxuvQhJZK22l/9r9CWJOg0DS86jZtcaQh7aOXIvEcJScF7Ok
         f1De/N0zU6n51ouVW47RrvM7WwtRX3zQ6XL2CShrK9VD6qBoCldkk1cGu3gNQfA6TkC5
         TJstao418sb3HOsBqnksQoDlmtrNONTksBGZgrTrac183prRiwnTNAEXjdBwFwdWpUa/
         GVOw==
X-Gm-Message-State: AGi0PuaWmlO1ad8SwnobRwGu7d+o7wE5Xt7CBuFHTWQgRFxdoPHUcQ5y
        64lyfD8gi/W7jlSIXd3pJwI=
X-Google-Smtp-Source: APiQypJtL9xhcxuM9fPTVSO6dKk/6nF9FDND7wPbG6jLXVS0MEj1bH2UBTn5A09xp28sqTH0iKqjtg==
X-Received: by 2002:a37:4fc5:: with SMTP id d188mr4156132qkb.220.1586528962908;
        Fri, 10 Apr 2020 07:29:22 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c12sm1605169qkj.128.2020.04.10.07.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 07:29:22 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 10 Apr 2020 10:29:20 -0400
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-x86_64@vger.kernel.org, nivedita@alum.mit.edu
Subject: Re: [Bug report] Kernel 5.7 become unbootable
Message-ID: <20200410142920.GA936997@rani.riverdale.lan>
References: <CABXGCsPpD+ExaeA6v+gSPPgtxcVzpKLWJNwGPPDKGFkPCv5kDg@mail.gmail.com>
 <1d02e4f3-8d83-4c55-bce2-f5aa4af2e363@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d02e4f3-8d83-4c55-bce2-f5aa4af2e363@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 04:16:58PM +0800, Like Xu wrote:
> On 2020/4/10 3:12, Mikhail Gavrilov wrote:
> > Hi folks.
> > I use Fedora Rawhide and today's update came with the new kernel
> > 5.7.0-0.rc0.git6.1.
> > As it turned out this kernel won't boot. Instead, I see the black
> > screen and some times see messages:
> > exit_boot() failed!
> > efi_main() failed!
> > 
> > The last working kernel is kernel-core-5.7.0-0.rc0.git2.1
> > 
> > I looked at the spec file and found out that the last bootable kernel
> > was related to the commit cad18da0afb1
> > (https://src.fedoraproject.org/rpms/kernel/c/9949db6070c6ca501d7235760ca8aba120db7448?branch=master),
> > and the first non-bootable kernel related to the commit a10c9c710f9e
> > (https://src.fedoraproject.org/rpms/kernel/c/0561e0bf0e459dd4b27a77670de838128b87bd0e?branch=master)
> > 
> > Of course, knowing these two commits, I made bisecting with the vanilla kernel:
> > 
> > 
> > Can anyone here help me with this issue?
> 
> I encountered the same issue as you:
> 
> exit_boot() failed!
> efi_main() failed!
> 
> and the following patches are very suspicious:
> 
> x86/boot/compressed/64: Use LEA to initialize boot stack pointer
> x86/boot/compressed/64: Use 32-bit (zero-extended) MOV for z_output_len
> x86/boot/compressed/64: Remove .bss/.pgtable from bzImage
> x86/boot/compressed: Remove .eh_frame section from bzImage
> 
> I am not sure if reverting these patches can help you.
> 
> Thanks,
> Like Xu
> 

Please try with the patches at
https://lore.kernel.org/linux-efi/20200409130434.6736-1-ardb@kernel.org/

In particular, patches 3 and 4. The first one is a fix for upstream
commit 3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")
