Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC26AC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB87E206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgEEOiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:38:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:10448 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbgEEOiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:38:10 -0400
IronPort-SDR: LJIv8flpL0DOywwYbtQu5Hl8LrWdqdaH6V2Dqx7GplVt/wXlIzbf9ciy7uAtbQqyzVWBVVfBTK
 b9kdr44se+dw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 07:38:10 -0700
IronPort-SDR: FWtAd1kDyXb7Jwvx402XLN432nPl1pZL/T1Abu+ZisNKd8aDkusbQdrCa19Ey81VCSABByadA/
 uJBokpct78oQ==
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="434507883"
Received: from lhawrylk-desk.ger.corp.intel.com ([10.213.12.77])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 07:38:05 -0700
Message-ID: <2dad6366d2fceb0a9e36f284a8ed5a8ed86d8756.camel@linux.intel.com>
Subject: Re: [GRUB PATCH RFC 00/18] i386: Intel TXT secure launcher
From:   Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
To:     Daniel Kiper <daniel.kiper@oracle.com>, grub-devel@gnu.org,
        linux-kernel@vger.kernel.org, trenchboot-devel@googlegroups.com,
        x86@kernel.org
Cc:     alexander.burmashev@oracle.com, andrew.cooper3@citrix.com,
        ard.biesheuvel@linaro.org, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, javierm@redhat.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        mjg59@google.com, phcoder@gmail.com, pirot.krol@3mdeb.com,
        pjones@redhat.com, ross.philipson@oracle.com
Date:   Tue, 05 May 2020 16:38:02 +0200
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-05 at 01:21 +0200, Daniel Kiper wrote:
> Hi,
> 
> This is an RFC patchset for the GRUB introducing the Intel TXT secure launcher.
> This is a part of larger work known as the TrenchBoot. Patchset can be split
> into two distinct parts:
>   - 01-12: preparatory patches,
>   - 13-18: the Intel TXT secure launcher itself.
> 
> The initial implementation of the Intel TXT secure launcher works. However,
> there are still some missing bits and pieces, e.g.:
>   - SINIT ACM auto loader,
>   - lack of RMRR support,
>   - lack of support for MLEs larger than 1 GiB,
>   - lack of TPM 1.2 support.
>   - various fixes and cleanups.
> 
> Commands introduced by this patchset: tpm_type, slaunch, slaunch_module (not
> required on server platforms) and slaunch_state (useful for checking platform
> configuration and state; based on tboot's txt-stat).
> 
> Daniel
> 

Hi Daniel

Your patch looks promising, however I have few concerns.

In OS-MLE table there is a buffer for TPM event log, however I see that
you are not using it, but instead allocate space somewhere in the
memory. I am just wondering if, from security perspective, it will be
better to use memory from TXT heap for event log, like we do in TBOOT.

There is a function that verifies if platform is TXT capable
-grub_txt_verify_platform(), it only checks SMX and GETSEC features.
Although BIOS should enforce both VMX and VT-d enabled when enabling
TXT, I think that adding these check here as redundancy may be a good
idea. The same situation is with TPM presence.

I suggest to add possibility to skip TXT launch when last boot ended
with TXT error. This option can avoid boot loops when something goes
wrong.

How will you read LCP from storage? I see that there is slaunch_module
command that currently you are using only for loading SINIT. In the
future it can be expanded to support LCP file too, what do you think?

Do not forget to apply changes required by latest Intel's platforms, you
should check following commits in TBOOT's repository: 2f03b57ffdba,
fe2dddd742dc.

Lukasz 

