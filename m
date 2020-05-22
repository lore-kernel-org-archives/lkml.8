Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83BCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B3D204EA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbgEVWkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:40:51 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39705 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgEVWku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:40:50 -0400
Received: by mail-il1-f193.google.com with SMTP id c20so12367530ilk.6;
        Fri, 22 May 2020 15:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9O1ztl73QCyaz4czM7KN6rZzxlSQiG/LQQETJdvECE=;
        b=qywbsa09nrFJ9IcOsm5wHV/D/3rQbDkB7zXtN8FlDG41tyOseF6tA3d0GvxHm3bhcq
         Grj6YYlFS+EikpydQKXYOgH2uFL7a9xUKLh2TLLxtgRNtt49xJhVk1LZcncAuRU8OU5/
         N/1TkKW43TYc8M/it9lE4uge+hzUuxNkHgLkPM8+k9gO/MJIZleo9fcJhpk8zJQT7LWt
         gOTIAUCRUGKEgx5d4dms+O0xwGL/+nCAKj/H/ZAwQnKNDjWhidYnJ4SoRGY68qymUk7f
         2/GYQq3Kn+C9L6MbctHqNUW1QOf3FjpCNuqfqodujijT0EAYxtSl0EDcB9p6RW30fnpw
         oKMw==
X-Gm-Message-State: AOAM530ERGKPFNF6lXmk0nLpkkX7e3HsYMMRK/2LA++S7HkY2PJl2yXA
        bvPCXPn5lBUqx1IhoSLnQadyutxpJqw=
X-Google-Smtp-Source: ABdhPJwFf0FNqC6ZgYM/FHrk3wPlyCTZJJB3LVatxCaJKD4IqZ24qDgivXe1I/k+FmhXZCfV1ejcNA==
X-Received: by 2002:a05:6e02:ec2:: with SMTP id i2mr15593326ilk.262.1590187248869;
        Fri, 22 May 2020 15:40:48 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id l21sm2016938ili.8.2020.05.22.15.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 15:40:48 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id d7so13194450ioq.5;
        Fri, 22 May 2020 15:40:48 -0700 (PDT)
X-Received: by 2002:a02:5e81:: with SMTP id h123mr9862796jab.99.1590187248159;
 Fri, 22 May 2020 15:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200410015832.8012-1-tangbin@cmss.chinamobile.com>
 <be8cd229-884a-40e6-3363-7c4680a51b30@web.de> <0b718268-d330-dfc1-aca3-3dd3203363d7@cmss.chinamobile.com>
 <20200414083036.GC14722@kadam> <f712918c-2f61-0ba5-2ba8-b5ca3cce9a35@cmss.chinamobile.com>
In-Reply-To: <f712918c-2f61-0ba5-2ba8-b5ca3cce9a35@cmss.chinamobile.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 22 May 2020 17:40:24 -0500
X-Gmail-Original-Message-ID: <CADRPPNRJe6aE3MXjK0z6uYtey3smU8cbFcGBqqv0ELJ9SxApvQ@mail.gmail.com>
Message-ID: <CADRPPNRJe6aE3MXjK0z6uYtey3smU8cbFcGBqqv0ELJ9SxApvQ@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: fsl: Fix a wrong judgment in fsl_udc_probe()
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 4:13 AM Tang Bin <tangbin@cmss.chinamobile.com> wrote:
>
> Hi
>
> On 2020/4/14 16:30, Dan Carpenter wrote:
> > On Fri, Apr 10, 2020 at 04:05:06PM +0800, Tang Bin wrote:
> >>>
> >>>> Thus it must be fixed.
> >>> Wording alternative:
> >>>     Thus adjust the error detection and corresponding exception handling.
> >> Got it.
> > Wow...
> >
> > No, don't listen to Markus when it comes to writing commit messages.
> > You couldn't find worse advice anywhere.  :P
>
> I'm actively waiting for a reply from the maintainer. Thank you very much.

Sorry for the late response.

Acked-by: Li Yang <leoyang.li@nxp.com>

Regards,
Leo
