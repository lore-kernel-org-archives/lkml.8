Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791A1C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567A120724
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587673006;
	bh=yDRyi2sOUcpSpYGMAyXU8sfLn/N73rFFh6EAByD8Afk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cl4zD9HH7o0ISq3zzkspBGH5F9L/35qDtxoEEJk/kUFHWteR+ioI19Ft542UjVIPR
	 IKeZ7y300U5lrkbss5zPn8TDWGEVp9lK3HOMNQndOazY+PS5YpYYshqAHd1wMJciMe
	 uWS69l4MpYSvH9sI3WWC+MRzNqbx0HxYGRxSjq8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDWUQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:16:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36034 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDWUQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:16:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id z1so1846702pfn.3;
        Thu, 23 Apr 2020 13:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gDxhnCkXKhJOqO4U3akxjRKoyln9yVYvcD5bsauPEMA=;
        b=HKchlR6DNPcYoVvlMHZgt5cpkFAVGzj1fv2GqdYs24tudMr2ChrWJPzyEi6g8RWzYE
         pfZT59iOodEYYTeM4Je8XurzLkQy9AuM9n+BP+ma0vpuhQ5TYctDMqL3EX5xIj1iusQS
         SI27fDXiIMCy35K8+XtuHBML+2hcjmn5EMvVaK/FE/T+DymhGTLElzYBbmkoM4gAxYA4
         LyW1ULVRCUwesv2sd4qKOZYnh/BRRtbFIo7+HrayHj5aYGpEQkZUb2gnLXCxF5vTGCmD
         BHNweqY31S6tgQg/qMC460C095RbhvUrX0CEEUIaUbUHSN2zXOZDikZj3EoAL+olTk0u
         MBUg==
X-Gm-Message-State: AGi0PuaxgzoxjI5joDadfmmL5/YMlnx2YLVZ10UdcgVlAgQsDgP34nYU
        hx8CFFzw+jN82m4Pbcm5WHk=
X-Google-Smtp-Source: APiQypKW6L14oiexkS+Ti4cInlGxLtbGC7kOmTR9i7m2y/ehhC2L3qeek56YZu8+n8hFHjuK6Rl0Kg==
X-Received: by 2002:aa7:808e:: with SMTP id v14mr1452753pff.168.1587673004235;
        Thu, 23 Apr 2020 13:16:44 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v94sm3144082pjb.39.2020.04.23.13.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 13:16:42 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A485C402A1; Thu, 23 Apr 2020 20:16:41 +0000 (UTC)
Date:   Thu, 23 Apr 2020 20:16:41 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Apr 23 (firmware_loader)
Message-ID: <20200423201641.GY11244@42.do-not-panic.com>
References: <20200423174104.239dffab@canb.auug.org.au>
 <9cb037fe-0a9d-9fda-08f1-87c560069419@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb037fe-0a9d-9fda-08f1-87c560069419@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 07:50:32AM -0700, Randy Dunlap wrote:
> On 4/23/20 12:41 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20200422:
> > 
> 
> on i386:
> 
> ERROR: modpost: "fw_fallback_config" [drivers/base/firmware_loader/firmware_class.ko] undefined!
> 
> Full randconfig file is attached.

Christoph's recent patch, fortunately not yet upstream, broke this. I'll
send a fix as his other un-export was fine.

  Luis
