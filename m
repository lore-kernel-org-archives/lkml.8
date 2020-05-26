Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933ADC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD14208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HAbAmGea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgEZEbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 00:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgEZEbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 00:31:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B41C061A0E;
        Mon, 25 May 2020 21:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=vXFd2CE8sJRaDeTwRK+vX0MCpo0iNPmCqKp/WJoBVcE=; b=HAbAmGeaZahNaWDrHfheZtlxGT
        a0D3TPLN4AotQgdwYTr67W4S6qtlyDqYUvVCWhMUhcy93Lw5ippMHmkSOB0ExT0Ff5FlnVvatDn74
        J/YDRIy/U77XNU2DC8KmUQOfbZlZQLu98BODyiUBmkopL9GIWun+bqE4PtaN2rXQOZOpWlE5v6ynU
        JCrxQ7d7pumskkEx01+2fxq38FLhZvoX1Uod6TaVPFqungpjpQWAh2PZycN0yxNiKT3BJuQNZuLcf
        7d7AoW3RXDA2kFRJ9fEnW6pVm02JK/2L1TxKR3mZ+FvKCzzAWvCg/QCys3qSOeYaxK+8vpdwXwgBd
        R/qXC6PA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdRFU-00050m-0P; Tue, 26 May 2020 04:31:32 +0000
Subject: Re: mmotm 2020-05-25-16-56 uploaded (drm/nouveau)
To:     Dave Airlie <airlied@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-next <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.cz>, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
References: <20200525235712.VqEFGWfKu%akpm@linux-foundation.org>
 <21b52c28-3ace-cd13-d8ce-f38f2c6b2a96@infradead.org>
 <CAPM=9twdkW83Wd4G1pS7cP2nf3wOmYvKxUfKA9EUkOEf7BuvKg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a5bc5156-6f50-7672-6c00-8f8394dc1416@infradead.org>
Date:   Mon, 25 May 2020 21:31:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPM=9twdkW83Wd4G1pS7cP2nf3wOmYvKxUfKA9EUkOEf7BuvKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/20 9:23 PM, Dave Airlie wrote:
> On Tue, 26 May 2020 at 13:50, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 5/25/20 4:57 PM, Andrew Morton wrote:
>>> The mm-of-the-moment snapshot 2020-05-25-16-56 has been uploaded to
>>>
>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>> http://ozlabs.org/~akpm/mmotm/series
>>>
>>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>>> followed by the base kernel version against which this patch series is to
>>> be applied.
>>>
>>
>> on x86_64:
>>
>> when CONFIG_DRM_NOUVEAU=y and CONFIG_FB=m:
>>
>> ld: drivers/gpu/drm/nouveau/nouveau_drm.o: in function `nouveau_drm_probe':
>> nouveau_drm.c:(.text+0x1d67): undefined reference to `remove_conflicting_pci_framebuffers'
> 
> I've pushed the fix for this to drm-next.
> 
> Ben just used the wrong API.

That patch is
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

thanks.
-- 
~Randy
