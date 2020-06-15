Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F93C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E500B204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrIgBNYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgFOIHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:07:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60508 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728260AbgFOIHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592208450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+QGlrYD7CnoOZ2xHryUMQtseNDSspP2GFuEENx6xWTg=;
        b=VrIgBNYlMGKy6UO4WmzacP34+IIpvHd/rJxBAj7B2IpGMXslse3177ixUp6sxI9axS+0+U
        EZIA4hAai0WUcY/9qk9moilj+4c63kEqtKG/CzLqA4Dmosn70hGUaENpEG6Hv0Hur58ONF
        /LGRgZ2/DmdqvlzOwuB94I+XI2PWUaA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-Lc43Fhx-MuOJ-KOWhdEqMQ-1; Mon, 15 Jun 2020 04:07:27 -0400
X-MC-Unique: Lc43Fhx-MuOJ-KOWhdEqMQ-1
Received: by mail-pl1-f199.google.com with SMTP id d13so1655624plr.20
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+QGlrYD7CnoOZ2xHryUMQtseNDSspP2GFuEENx6xWTg=;
        b=Ourf6lJCv9nd4ugYhl5a/Q9jky2ysltuJChZa5EkrOgohoYZiNfmLTsZ5IOh/6fsjO
         89ZUe6DCOuPa4S2GaDeIgtuN9z8t0YrA2C35QH2QedM33BDx3bz1edg0tyfinY8d7Fci
         bhXgtKplndftyhv9u8uNFesEk9pw44djunDxcj2X1ID56htCeOXPI3p6kOIdd5oJBC86
         wM3XiY91kb/1QCR3TUl6bL5lDGR95i4tbVWAqyagpbD12GzVI46HeB9U7eXQFosLNhfD
         p0SSrJfKUqmZx2mDKzZcCyXI4Z7Eu8EWEB82bkFrYPhHB7GT1DyjzXsZWNjtgSkYYIhr
         gH2Q==
X-Gm-Message-State: AOAM530Y5r3G3mIN9o47lMX7UKk8T6Mbxb33lJ3T020h1wlI95/7XQlE
        TR8A2hYLEX7MfACnz9YD/XQJuAUodu5zNjPAKuI2Ju2hxQe7T6jP6rlt6s7PeE0Lk0wJSi21C9V
        k8ZAf7H8v1Qw7QzhkV3JxE/E/
X-Received: by 2002:a17:90a:ad03:: with SMTP id r3mr11041326pjq.104.1592208446518;
        Mon, 15 Jun 2020 01:07:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzQIhf04M46QfAh9dC0OF2x3Gg0pBCHU0ZNkauVlVtPuKKppWZqX7qMQYC9uA7dNku9F6pOQ==
X-Received: by 2002:a17:90a:ad03:: with SMTP id r3mr11041302pjq.104.1592208446284;
        Mon, 15 Jun 2020 01:07:26 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o2sm11603522pjp.53.2020.06.15.01.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:07:25 -0700 (PDT)
Date:   Mon, 15 Jun 2020 16:07:14 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     xiang@kernel.org, chao@kernel.org, gregkh@linuxfoundation.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] erofs: Eliminate usage of uninitialized_var() macro
Message-ID: <20200615080714.GB25317@xiangao.remote.csb>
References: <20200615040141.3627746-1-yanaijie@huawei.com>
 <20200615072521.GA25317@xiangao.remote.csb>
 <783fe4f9-fb1f-7f5e-c900-7e30d5c85222@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <783fe4f9-fb1f-7f5e-c900-7e30d5c85222@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 03:43:09PM +0800, Jason Yan wrote:
> 
> 
> ÔÚ 2020/6/15 15:25, Gao Xiang Ð´µÀ:
> > Hi Jason,
> > 
> > On Mon, Jun 15, 2020 at 12:01:41PM +0800, Jason Yan wrote:
> > > This is an effort to eliminate the uninitialized_var() macro[1].
> > > 
> > > The use of this macro is the wrong solution because it forces off ANY
> > > analysis by the compiler for a given variable. It even masks "unused
> > > variable" warnings.
> > > 
> > > Quoted from Linus[2]:
> > > 
> > > "It's a horrible thing to use, in that it adds extra cruft to the
> > > source code, and then shuts up a compiler warning (even the _reliable_
> > > warnings from gcc)."
> > > 
> > > The gcc option "-Wmaybe-uninitialized" has been disabled and this change
> > > will not produce any warnnings even with "make W=1".
> > > 
> > > [1] https://github.com/KSPP/linux/issues/81
> > > [2] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
> > > 
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Chao Yu <yuchao0@huawei.com>
> > > Signed-off-by: Jason Yan <yanaijie@huawei.com>
> > > ---
> > 
> > I'm fine with the patch since "-Wmaybe-uninitialized" has been disabled and
> > I've also asked Kees for it in private previously.
> > 
> > I still remembered that Kees sent out a treewide patch. Sorry about that
> > I don't catch up it... But what is wrong with the original patchset?
> > 
> 
> Yes, Kees has remind me of that and I will let him handle it. So you can
> ignore this patch.

Okay, I was just wondering if this part should be send out via EROFS tree
for this cycle. However if there was an automatic generated patch by Kees,
I think perhaps Linus could pick them out directly. But anyway, both ways
are fine with me. ;) Ping me when needed.

Thanks,
Gao Xiang

> 
> Thanks,
> Jason
> 
> > Thanks,
> > Gao Xiang
> > 
> > 
> > .
> > 
> 

