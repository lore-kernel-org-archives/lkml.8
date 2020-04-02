Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4299DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138A92078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axglwSAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389069AbgDBUsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:48:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20172 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726617AbgDBUsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585860479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Rc2v05BJ2MWLUOtCg/UMGos43tuREKXY5mt9KFY3Y0=;
        b=axglwSAW9W4yPsD+puN+v+m7E9aCI+etj6REpWQO6LjKeUmhuc0gjq6R2NOv/rSMgdpObN
        grGvvHivgYPOy0fxv5B7LWkaDdiJfc9rsfUWE2CsgTBac5sqlNX/WueUtBXGL6Nw2gFyM9
        44+2FJliWApNvJ9Qf9brZR7eLDdQDqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-ptPNqkgLPCGcXekziwlFuw-1; Thu, 02 Apr 2020 16:47:56 -0400
X-MC-Unique: ptPNqkgLPCGcXekziwlFuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F5F5107ACC9;
        Thu,  2 Apr 2020 20:47:54 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 515FF92FAD;
        Thu,  2 Apr 2020 20:47:52 +0000 (UTC)
Date:   Thu, 2 Apr 2020 15:47:49 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Singh, Balbir" <sblbir@amazon.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re: [PATCH 0/3] arch/x86: Optionally flush L1D on context switch
Message-ID: <20200402204749.33ulub5jx66dktxg@treble>
References: <20200402062401.29856-1-sblbir@amazon.com>
 <20200402201328.zqnxwaetpk4ubg56@treble>
 <31c9720eff18ce167378e9a0017dcd73e0552164.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31c9720eff18ce167378e9a0017dcd73e0552164.camel@amazon.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 08:35:46PM +0000, Singh, Balbir wrote:
> On Thu, 2020-04-02 at 15:13 -0500, Josh Poimboeuf wrote:
> > CAUTION: This email originated from outside of the organization. Do not
> > click links or open attachments unless you can confirm the sender and know
> > the content is safe.
> > 
> > 
> > 
> > On Thu, Apr 02, 2020 at 05:23:58PM +1100, Balbir Singh wrote:
> > > Provide a mechanisn to flush the L1D cache on context switch.  The goal
> > > is to allow tasks that are paranoid due to the recent snoop assisted data
> > > sampling vulnerabilites, to flush their L1D on being switched out.
> > 
> > Hi Balbir,
> > 
> > Just curious, is it really vulnerabilities, plural?  I thought there was
> > only one: CVE-2020-0550 (Snoop-assisted L1 Data Sampling).
> > 
> > (There was a similar one without the "snoop": L1D Eviction Sampling, but
> > it's supposed to get fixed in microcode).
> > 
> 
> Hi, Josh
> 
> Yes, that CVE the motivation, the mitigation for CVE-2020-0550 does suggest
> flushing the cache on context switch. But in general, as we begin to find more
> ways of evicting data or snopping data, a generic mechanism is more useful and
> that is why I am making it an opt-in.

Ok.  I think it would be a good idea to expand on that justification
more precisely in the commit message.  That would help both reviewers of
the code and users of the new option understand what level of paranoia
they're opting in to :-)

-- 
Josh

