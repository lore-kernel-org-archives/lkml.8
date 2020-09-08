Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC027C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7010221D46
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599551258;
	bh=mEjPx2kedNNVqke8gtYjeHgXCKotuHFDn/V8y6HlZ4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AmGf0fMv3tFhT4GmGsq3N2RcNu1Q7oF5wT5wfdeSDtcU0/+stOZ3AUnLoPq8lHifM
	 HDzAgA9bbojTlQpAMc7PQjSSl7/A7ryltTGnRhIdM51i6fKf2HGmxnJPObGSCDfflw
	 VbEHK/mIVSO7aHLzknoyBAv7NICkNrPjZcrHgiso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgIHHrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:47:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbgIHHrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:47:36 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B33A121D43;
        Tue,  8 Sep 2020 07:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599551255;
        bh=mEjPx2kedNNVqke8gtYjeHgXCKotuHFDn/V8y6HlZ4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f05USdwn0f1N/tYFfRQflIZ44UF4bl++1ybwuP/jMBwPoZ4JO27SKYcqk2fhGKEZV
         Sj9FpRwd1T/Cgv00szHFLQ1eE8VOMwcdEK0CcBY5oIAX5IHoV7xtHeCyciJ/GACYl5
         uev7/0I+rwa5h2HsYRv7DJUr863O2i1t+SOWIwao=
Received: by pali.im (Postfix)
        id 4FA59617; Tue,  8 Sep 2020 09:47:33 +0200 (CEST)
Date:   Tue, 8 Sep 2020 09:47:33 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Andre Heider <a.heider@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch
 aliases
Message-ID: <20200908074733.f33pwtreojzobivq@pali>
References: <20200907112718.5994-1-pali@kernel.org>
 <20200907144228.GV3112546@lunn.ch>
 <20200907145213.fwlyz4k6scible7x@pali>
 <20200907154353.GW3112546@lunn.ch>
 <20200907161316.xd5svvahi5xusdlw@pali>
 <20200907172345.GB3254313@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200907172345.GB3254313@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 September 2020 19:23:45 Andrew Lunn wrote:
> On Mon, Sep 07, 2020 at 06:13:16PM +0200, Pali Rohár wrote:
> > On Monday 07 September 2020 17:43:53 Andrew Lunn wrote:
> > > > I would not say it is a "new feature". But rather that patch in this
> > > > email fixes issue that Linux kernel did not set correct MAC address for
> > > > DSA slave ports. I think it is something which could be backported also
> > > > to stable releases as "ignoring" vendor/factory MAC address is not
> > > > correct behavior.
> > > 
> > > Hi Pali
> > > 
> > > The rules for stable are here:
> > > 
> > > https://www.kernel.org/doc/html/v5.8/process/stable-kernel-rules.html
> > > 
> > > Do you think it fits?
> > > 
> > >    Andrew
> > 
> > Hello Andrew! I think it fits into those rules. As I wrote it fixes real
> > bug that Linux kernel does not use correct MAC address for particular
> > DSA slaves / ethernet ports.
> 
> O.K, then:
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew

Ok! Andrew, I would like to ask another question, how to correctly
define that this patch depends on a2c7023f7075c? I specified it in
human-readable part of commit description, but for backporting it would
also need some machine-readable format. So patch would not be
occasionally backported to older/stable kernel where a2c7023f7075c is
not available.
