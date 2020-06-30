Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50588C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310D1206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7fj2XBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgF3So0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:44:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42555 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgF3SoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593542662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PedFDc2DtQMOIGWMojnCcvUFPVJqYYNEpNxS2Hp4sso=;
        b=i7fj2XBv3if4K7+j7KNAQtaSAoTUBGb7H2DlLBcgqbCN6wYRBXx0Nf8ZpZIJyhN8ASuGHe
        /WfS0RGr62yiyTpGbPqU6GWu0w7m7jdDq5ydDEsQ0CbSlbJYpm7648vZNvMZDlpDrE/YIx
        XcXxLo8gf+1H5hMCRIiBme8keSGI62U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-Sc-geY15PtKpUIgIcEiQ5w-1; Tue, 30 Jun 2020 14:44:20 -0400
X-MC-Unique: Sc-geY15PtKpUIgIcEiQ5w-1
Received: by mail-qt1-f197.google.com with SMTP id e6so14117483qtb.19
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PedFDc2DtQMOIGWMojnCcvUFPVJqYYNEpNxS2Hp4sso=;
        b=SVZpXFfKnKIoCIshLZZx2jfpCarn9Z5wGCL5adXc4kviFdglJB1s9YRY9Ez8ePs2Rb
         vGV4axkvbuPdN3bGzDOS3g1t+Y30ARi4UknbbtIIAR6skPAxN6Jp77prnlsf01Sd9Law
         +46fbpobgw/ChieGnq3ugpbwdcPp6RIkY4MzRR8mmiapD3SS//hwoWlFun4qUhcddkP3
         Hg2gHNzCpJHnB1TRkZMVIDB6uprovRZQDafPiZ8jieZNZ+7rFN1xUe5Rnb7GTPe0XdH/
         Qpm0Yr4gskiC+k2Q4QpVZ3rBS6Aqoyc9dSMyQVwmal+It41TCSwDrydLnD07FkfiSJud
         DXwQ==
X-Gm-Message-State: AOAM531KpoA08q+Og1k4AFsiYjRlXkVQvf46kajOcPjSDRII8fg1gI+c
        LSs2JB9kw4GgjQ3eAuM9cVz4gmBn8/XNcisEZqoaM+rZl8lhw4WykAMyJoY/aBWSBPy54nPu2CS
        fIkknvQc63UrOlYciqw+6AGVH
X-Received: by 2002:a37:a14c:: with SMTP id k73mr21323494qke.145.1593542659924;
        Tue, 30 Jun 2020 11:44:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwBx2LZuulFWLqg/mQP1Ihml2J1c5LqD4NJxngK+OBmKCXx8SAyvZunhLXcfXhUVrRNoRbpA==
X-Received: by 2002:a37:a14c:: with SMTP id k73mr21323479qke.145.1593542659736;
        Tue, 30 Jun 2020 11:44:19 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a11sm3208689qkh.103.2020.06.30.11.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 11:44:18 -0700 (PDT)
Subject: Re: [RFC 1/1] fpga: dfl: RFC PCI config
To:     Randy Dunlap <rdunlap@infradead.org>, hao.wu@intel.com,
        mdf@kernel.org, corbet@lwn.net
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200630171656.20151-1-trix@redhat.com>
 <20200630171656.20151-2-trix@redhat.com>
 <67f7f2b8-3567-aadd-30d6-4cfbc0bc8ce5@infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <78a250ab-29ad-f7cb-3fa2-482e76db207a@redhat.com>
Date:   Tue, 30 Jun 2020 11:44:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <67f7f2b8-3567-aadd-30d6-4cfbc0bc8ce5@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I haven't tested this, but in general it's not safe to select something like
> SENSORS* or HWMON* unless you first check that CONFIG_HWMON is enabled.
> Otherwise this would usually cause kconfig warning(s).
>
> But don't add things like
> 	select HWMON
> 	select SPI
> 	select SPI_MASTER
>
> because we don't enable subsystems (like HWMON or SPI) just inside one
> driver's kconfig entry.
> The driver(s) should instead depend on HWMON, SPI, SPI_MASTER etc.

Yes, I thought this was ugly. The next rev addresses this issue.  The config will not be fully automagic.  User will have enough information in the doc to figure out the other subsystems.  

Tom

