Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB86CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C74204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388151AbgEMNr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:47:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:5072 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgEMNr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:47:26 -0400
IronPort-SDR: EXCtIL+YRbdcxYFtALXnhCa/psN9R1koqx0bCs7WtbgYTNM9MiUryoMUD1/l9QV5h/gulij/E1
 IRg0FVIGfWig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 06:47:26 -0700
IronPort-SDR: pNqlTqHsTVGc/mVmZM9FvraTTA2PsxB4ZVZwANI3eH9UxRZx4i0sJ6GmytwqL+XeaojD3r6byj
 hQvKPWqhUHhQ==
X-IronPort-AV: E=Sophos;i="5.73,387,1583222400"; 
   d="scan'208";a="409691293"
Received: from lhawrylk-desk.ger.corp.intel.com ([10.213.1.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 06:47:21 -0700
Message-ID: <657cc4d8c6a5791ec89ef122ee84f72ff60d4089.camel@linux.intel.com>
Subject: Re: [GRUB PATCH RFC 00/18] i386: Intel TXT secure launcher
From:   Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
To:     The development of GNU GRUB <grub-devel@gnu.org>
Cc:     linux-kernel@vger.kernel.org, trenchboot-devel@googlegroups.com,
        x86@kernel.org, alexander.burmashev@oracle.com,
        andrew.cooper3@citrix.com, ard.biesheuvel@linaro.org,
        dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        javierm@redhat.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, krystian.hebel@3mdeb.com,
        michal.zygowski@3mdeb.com, mjg59@google.com, phcoder@gmail.com,
        piotr.krol@3mdeb.com, pjones@redhat.com, ross.philipson@oracle.com
Date:   Wed, 13 May 2020 15:47:19 +0200
In-Reply-To: <20200507110634.2yvzirauq5md7d2q@tomti.i.net-space.pl>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
         <2dad6366d2fceb0a9e36f284a8ed5a8ed86d8756.camel@linux.intel.com>
         <20200507110634.2yvzirauq5md7d2q@tomti.i.net-space.pl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

On Thu, 2020-05-07 at 13:06 +0200, Daniel Kiper wrote:
> > There is a function that verifies if platform is TXT capable
> > -grub_txt_verify_platform(), it only checks SMX and GETSEC features.
> > Although BIOS should enforce both VMX and VT-d enabled when enabling
> > TXT, I think that adding these check here as redundancy may be a good
> 
> The TXT spec has the following pseudocode:
> 
>   //
>   // Intel TXT detection
>   // Execute on all logical processors for compatibility with
>   // multiple processor systems
>   //
>   1. CPUID(EAX=1);
>   2. IF (SMX not supported) OR (VMX not supported) {
>   3. Fail measured environment startup;
>   4. }
> 
> However, a few lines above you can find this:
> 
>   Lines 1 - 4: Before attempting to launch the measured environment, the
>   system software should check that all logical processors support VMX and
>   SMX (the check for VMX support is not necessary if the environment to be
>   launched will not use VMX).
> 
> Hence, AIUI, I am allowed to check SMX only. And I do not think that the
> bootloader should enforce VMX. If the kernel wants VMX then it should
> check the platform config. The booloader should just look for features
> which are really required to properly execute GETSEC[SENTER].

I agree with you that spec does not clearly define if VMX is required or
not. In theory you can use TXT without VMX, however this is highly
impractical because in that configuration it is impossible to use STM to
protect MLE from SMI handler as STM feature requires VMX.

All real-life MLE implementations should use STM to be compliant with
TXT idea that MLE does not have a security dependency on the pre-
existing software environment. You can find more information about STM
here: 

https://software.intel.com/content/dam/develop/external/us/en/documents/stm-user-guide-001-819978.pdf

Anyway, I have asked TXT spec owner to clarify VMX situation in next
document revision.

> 
> PS By the way, I found an issue in TXT spec. TXT.VER.FSBIF refers to
>    TXT.VER.EMIF which does not exist in spec. I suppose that it is
>    remnant from previous TXT spec versions. It seems to me that it
>    should be changed to TXT.VER.QPIIF. TXT.VER.QPIIF descriptions
>    properly, IMO, refers back to TXT.VER.FSBIF.

Yes, this is remnant from old document versions, thank you for finding
that issue. Here are changes that will go to next revision:

 * register 0x100 (TXT.VER.FSBIF) does not exist for many years and will
   be removed from TXT spec
 * register 0x200 is called TXT.VER.EMIF and indicates if chipset is
   debug of production fused

Thanks,
Lukasz

