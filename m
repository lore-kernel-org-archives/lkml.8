Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FA0C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AF1206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dhy5/MKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgD3OGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgD3Nwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:52:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D643C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:52:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x17so7006454wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5aejYnw4VSmDkXwBR2qWfZ3n0YMQYIyda8QYzwtLR08=;
        b=Dhy5/MKRGKwJgbKg6r+CL+0eTzACExchjS2kNyKFdv45zKMI1cbGx1WFdRvlRs0/kH
         bPtw+/LbTger2HYJHD23XA0C98R5P7qpTNMZWH6elsaWj2X4h8fjfPehyIiyIyZHfMZc
         5JO4HLHCw5MIDDMV/pleyIhpSbllvNfQBpipFSuDyDhP7K4h8OqV3+4edD7JZQf3vpap
         3eNF4DDnt63CTGJL/xGbJWqgWhC1hqwxLhXO/rlfdkdLZTubuky1OmGsEiWqSinmTYqF
         TuxFhzGszj8s0vuK7XdyNDnveyKNkkwkiMrWWUAxU95bIC6f+v20chfi6XV3E1AnVawG
         oOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5aejYnw4VSmDkXwBR2qWfZ3n0YMQYIyda8QYzwtLR08=;
        b=totbv8C/i837Q7WYu6tpQ59SFFvtlACpXBbIuvnIosztBqGTcvQXz+AMCLngpmEqai
         H8j0rcU7y5KypAtn8KJHlH7NzJqTU5Sh3uO8jW9icx4ePdcYv/5JD8OOnhOnxmgI45KV
         9QyM5LOr88BLLFuaO4UfMPaNBKQOi5rzCzgfIDah6ERDuIOo3pycacD7Xd5+zcifATfG
         Ric09a7wjFmJzm4zWolcsTnFC2l67CIPej+ABQdR7GzvZWW4wVRVAIR8/9Cq9+ZVfYdu
         +IS7DaqXb33EO+vV/o+KZMgYuder0pOzGkY7UF/p46CJkn1DkCL2ak8Z2knIDvaV4By7
         xirw==
X-Gm-Message-State: AGi0Pua96vDWdiZgLcTtgUM+MM2u4IEE+Q3XnIxTEqWE3pKSXFnussUy
        HpIeiwSxnT7gmqtZMTQWrWA=
X-Google-Smtp-Source: APiQypJtsaGseH9cY5zGNMLSwHCPW5Gl7XbXjf3mWknT+/+Tk8NHTL4ckW3FCMnWsH/1EWwzuL93lw==
X-Received: by 2002:a5d:6504:: with SMTP id x4mr4520153wru.164.1588254768408;
        Thu, 30 Apr 2020 06:52:48 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id d7sm3868403wrn.78.2020.04.30.06.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 06:52:47 -0700 (PDT)
Message-ID: <eae142f2141a6add4ab61f4d2d16fa590323ae3c.camel@gmail.com>
Subject: Re: [PATCH v3 2/5] w1_therm: adding sysfs entry to check device
 power
From:   Akira shimahara <akira215corp@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Apr 2020 15:52:46 +0200
In-Reply-To: <20200430112131.GA2945965@kroah.com>
References: <20200429133204.140081-1-akira215corp@gmail.com>
         <20200429134655.GB2132814@kroah.com> <330221588173223@mail.yandex.ru>
         <2602d65b534fc0e9d6738d3c670bdb07fd287e5b.camel@gmail.com>
         <20200430112131.GA2945965@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 30 avril 2020 à 13:21 +0200, Greg KH a écrit :
> On Thu, Apr 30, 2020 at 12:34:03PM +0200, Akira shimahara wrote:
> > Hello,
> > 
> > Le mercredi 29 avril 2020 à 18:18 +0300, Evgeniy Polyakov a écrit :
> > > Hi
> > > 
> > > 
> > > 
> > > 29.04.2020, 16:47, "Greg KH" <greg@kroah.com>:
> > > 
> > > 
> > > 
> > > > >  +What: /sys/bus/w1/devices/.../w1_slave
> > > > >  +Date: Apr 2020
> > > > >  +Contact: Akira Shimahara <akira215corp@gmail.com>
> > > > >  +Description:
> > > > >  + (RW) return the temperature in 1/1000 degC.
> > > > >  + *read*: return 2 lines with the hexa output data sent on
> > > > > the
> > > > >  + bus, return the CRC check and temperature in 1/1000 degC
> > > > the w1_slave file returns a temperature???
> > > > And sysfs is 1 value-per-file, not multiple lines.
> > > 
> > > It was 'content crc' previously, and probably a good idea would
> > > be to
> > > add just one file with 'content'
> >  
> > That's the purpose of the new sysfs entry 'temperature'. It only
> > content temperature. As already mentionned we have to keep the
> > w1_slave
> > entry for compatibility purpose, all existing user application
> > parse
> > this file.
> 
> That's fine, but the document you wrote here says the file is called
> "w1_slave", not "temperature" :)
> 

Yes because it is the patch 2/5. At this stage, I just create the
sysfs-driver-w1_therm doc for the old w1_slave sysfs entry. The
temperature  sysfs entry is introduce in v3 patch 3/5 (and v4 patch
7/9)and the sysfs-driver-w1_therm is updated accordingly.

Akira Shimahara

