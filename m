Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E76C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F492077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcNzEg9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390213AbgDCBms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 21:42:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37078 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389108AbgDCBmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 21:42:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id g23so5719573otq.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 18:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4tU1ijP1oUMss+gZHdPAOpYayM4wwWRsIDBObxKGiVc=;
        b=jcNzEg9v7lRqKPNG1zObRdcQjh+gk/bUr/tEisbEtBl1s86IubloinTf3XxKH1pJ48
         MjFvtnWUc4FVghMd0K9IIenpvKmY9xJRkA2egW8LZ+LUUY9tckpWwmoo04mhVO8gHDhV
         SUzUrFy6U0Mn7jHtBlYogC+rMizjsYnn5t1IaCgnhBSJ6fMfoeBs/iY7UEcpa6hr707z
         UtNoR4N/9LmswlUU+NqsLQwPd+MphCGsdz+ezQPXx6Qxej1ggf5ZYg3H5U8848PxyTmQ
         vza2rb0NNr2iNeTGReJyDtVvixNzXmqiCsRyLI+k8tQmVi4zeskFKPMFFRswTaGL8fZa
         03/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4tU1ijP1oUMss+gZHdPAOpYayM4wwWRsIDBObxKGiVc=;
        b=q7tK1KzHmYtFCAku31wJZ+Py87J7whgCI35YPW3/6jiFw6JU3dlidSFIY99Yzk2MYT
         tDQ3BXk8bJTXIozZ+XYopIC8s4YV7jyhDDd/doSKcYZyHZWpNDq/dcNxqmlPxHDKPPk/
         /y+S7xl12wB5LAmGoiX5niKZhhN2/9UUGdLquuiffoT6hKjBD4IXzCZ6wQ4YZ2MMSrYW
         A3I4JXf6bSzCYEtPE971w2jw7TGx/QKEIIOVJCwpiSiXAY8QwzYBvet1EKz4xjkh65a3
         WpSNiusr6MR6HbL6ms/iNsE7+kVOdyugecNLwYxC9IEM6wYY0kdyw/HMthZirige05LH
         /Rfg==
X-Gm-Message-State: AGi0PuYRczxk4lvXrmwk16UPvbSSw/LbmJ1zAoWnhXerC8Aai+PSQPVp
        SnMJmKPtxpRMONUYna4HSIE=
X-Google-Smtp-Source: APiQypIjc/3Kcx764w5UPeyBdHuFZB5UHNoMG0fMVVZwIaKCuUDWOWnh/81/cNN7S7CRo41v7K/A5g==
X-Received: by 2002:a4a:92cd:: with SMTP id j13mr5039878ooh.96.1585878166813;
        Thu, 02 Apr 2020 18:42:46 -0700 (PDT)
Received: from OptiPlexFedora ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id t19sm1809875oih.52.2020.04.02.18.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 18:42:46 -0700 (PDT)
Message-ID: <4bd376a6db77ef779972f377cc2c3789d03668e7.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: emxx_udc: Remove unused code
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Apr 2020 18:42:44 -0700
In-Reply-To: <20200403015057.7a972c79@elisabeth>
References: <20200402021706.788533-1-jbwyatt4@gmail.com>
         <20200403015057.7a972c79@elisabeth>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-03 at 01:50 +0200, Stefano Brivio wrote:
> On Wed,  1 Apr 2020 19:17:06 -0700
> "John B. Wyatt IV" <jbwyatt4@gmail.com> wrote:
> 
> > Remove unused code surrounded by an #if 0 block.
> > 
> > Code has not been altered since 2014 as reported by git blame.
> > 
> > Reported by checkpatch.
> > 
> > Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> > ---
> >  drivers/staging/emxx_udc/emxx_udc.h | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/staging/emxx_udc/emxx_udc.h
> > b/drivers/staging/emxx_udc/emxx_udc.h
> > index 9c2671cb32f7..bbfebe331033 100644
> > --- a/drivers/staging/emxx_udc/emxx_udc.h
> > +++ b/drivers/staging/emxx_udc/emxx_udc.h
> > @@ -9,12 +9,6 @@
> >  #define _LINUX_EMXX_H
> >  
> >  /*--------------------------------------------------------------
> > -------------*/
> > -/*----------------- Default undef */
> > -#if 0
> > -#define DEBUG
> > -#define UDC_DEBUG_DUMP
> > -#endif
> > -
> >  /*----------------- Default define */
> >  #define	USE_DMA	1
> >  #define USE_SUSPEND_WAIT	1
> 
> Formally, this is fine. But... think about it: this driver might be
> rather buggy, so the first thing one might want to do with it is to
> "enable" those two defines.
> 
> In general, that stuff has to disappear, and proper debugging
> facilities have to be used, but with a driver in this state, as long
> as
> proper debugging facilities aren't there, you might be doing more
> harm
> than good.

DEBUG is not actually used as far as I can tell (I am still new to
kernel debugging systems to please correct me). There is only a pair of
.c and .h files for this small driver.

UDC_DEBUG_DUMP is only used twice in the entire kernel-both for if
statements.

Should we just set it to:

#define UDC_DEBUG_DUMP 0

And leave the other 3 lines out? Please let me know for a v2.

> 
> -- 
> Stefano
> 

