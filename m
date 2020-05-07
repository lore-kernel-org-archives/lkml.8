Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3203C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BAB20725
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QfiAafpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgEGLJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:09:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34686 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEGLJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:09:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047B8r95082510;
        Thu, 7 May 2020 11:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=7mBhKt7R0HJK03uDqsZJ/edFNvMPNhL8YPF5X0L3o6M=;
 b=QfiAafpJ6FeCyoZNm2fhjr/VsWXLzha0xKBWRnoG9RDNATLdgcYVn3MlCsARbWkPPuVU
 7eTEITN7UAPgh3jSp6Rj9UgdLJfHwCGFqX2bePR4JzRofG2jDWaYPMmnd6oPaJv6tZlE
 BzJf8bZuYxzlvyYIjoUMathibNi2z25iKWWIU2XO1VFFsw2dozt9x02vB31fGstJF7nl
 YKpLmQLW6XeKYHVj913yFu/e9KmNt9sX/Vbdhm/FELVvVxH8YnQm8+BfQs04PHyTLmZX
 dWKlk/yanItG8O9i32ntDh6nqvhrIfW6aP/rWszaNAiP9emuCnLQ8pvlXXXq91oNVrRY Hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30veckgun7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 11:08:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047B6s8X013191;
        Thu, 7 May 2020 11:06:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30sjdxta5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 11:06:54 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 047B6fTt031243;
        Thu, 7 May 2020 11:06:41 GMT
Received: from tomti.i.net-space.pl (/10.175.171.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 04:06:41 -0700
Date:   Thu, 7 May 2020 13:06:34 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
Cc:     grub-devel@gnu.org, linux-kernel@vger.kernel.org,
        trenchboot-devel@googlegroups.com, x86@kernel.org,
        alexander.burmashev@oracle.com, andrew.cooper3@citrix.com,
        ard.biesheuvel@linaro.org, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, javierm@redhat.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        mjg59@google.com, phcoder@gmail.com, piotr.krol@3mdeb.com,
        pjones@redhat.com, ross.philipson@oracle.com
Subject: Re: [GRUB PATCH RFC 00/18] i386: Intel TXT secure launcher
Message-ID: <20200507110634.2yvzirauq5md7d2q@tomti.i.net-space.pl>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
 <2dad6366d2fceb0a9e36f284a8ed5a8ed86d8756.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2dad6366d2fceb0a9e36f284a8ed5a8ed86d8756.camel@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Łukasz,

On Tue, May 05, 2020 at 04:38:02PM +0200, Lukasz Hawrylko wrote:
> On Tue, 2020-05-05 at 01:21 +0200, Daniel Kiper wrote:
> > Hi,
> >
> > This is an RFC patchset for the GRUB introducing the Intel TXT secure launcher.
> > This is a part of larger work known as the TrenchBoot. Patchset can be split
> > into two distinct parts:
> >   - 01-12: preparatory patches,
> >   - 13-18: the Intel TXT secure launcher itself.
> >
> > The initial implementation of the Intel TXT secure launcher works. However,
> > there are still some missing bits and pieces, e.g.:
> >   - SINIT ACM auto loader,
> >   - lack of RMRR support,
> >   - lack of support for MLEs larger than 1 GiB,
> >   - lack of TPM 1.2 support.
> >   - various fixes and cleanups.
> >
> > Commands introduced by this patchset: tpm_type, slaunch, slaunch_module (not
> > required on server platforms) and slaunch_state (useful for checking platform
> > configuration and state; based on tboot's txt-stat).
> >
> > Daniel
> >
>
> Hi Daniel
>
> Your patch looks promising, however I have few concerns.

Below I will be referring to the Intel Trusted Execution Technology
(Intel TXT), Software Development Guide, December 2019, Revision 016.
So, the latest and greatest...

> In OS-MLE table there is a buffer for TPM event log, however I see that
> you are not using it, but instead allocate space somewhere in the

I think that this part requires more discussion. In my opinion we should
have this region dynamically allocated because it gives us more flexibility.
Of course there is a question about the size of this buffer too. I am
not sure about that because I have not checked yet how many log entries
are created by the SINIT ACM. Though probably it should not be large...

> memory. I am just wondering if, from security perspective, it will be
> better to use memory from TXT heap for event log, like we do in TBOOT.

Appendix F, TPM Event Log, has following sentence: There are no
requirements for event log to be in DMA protected memory – SINIT will
not enforce it.

I was thinking about it and it seems to me that the TPM event log does
not require any special protections. Any changes in it can be quickly
detected by comparing hashes with the TPM PCRs. Does not it?

> There is a function that verifies if platform is TXT capable
> -grub_txt_verify_platform(), it only checks SMX and GETSEC features.
> Although BIOS should enforce both VMX and VT-d enabled when enabling
> TXT, I think that adding these check here as redundancy may be a good

The TXT spec has the following pseudocode:

  //
  // Intel TXT detection
  // Execute on all logical processors for compatibility with
  // multiple processor systems
  //
  1. CPUID(EAX=1);
  2. IF (SMX not supported) OR (VMX not supported) {
  3. Fail measured environment startup;
  4. }

However, a few lines above you can find this:

  Lines 1 - 4: Before attempting to launch the measured environment, the
  system software should check that all logical processors support VMX and
  SMX (the check for VMX support is not necessary if the environment to be
  launched will not use VMX).

Hence, AIUI, I am allowed to check SMX only. And I do not think that the
bootloader should enforce VMX. If the kernel wants VMX then it should
check the platform config. The booloader should just look for features
which are really required to properly execute GETSEC[SENTER].

> idea. The same situation is with TPM presence.

The TPM presence is checked in init_txt_heap(). However, we can do it earlier.

> I suggest to add possibility to skip TXT launch when last boot ended
> with TXT error. This option can avoid boot loops when something goes
> wrong.

grub_txt_verify_platform() checks TXT_RESET.STS bit and fails if it is
set. This produces an error during boot. Well, but it does not prevent
it... :-( Probably I have to fix it...

> How will you read LCP from storage? I see that there is slaunch_module
> command that currently you are using only for loading SINIT. In the
> future it can be expanded to support LCP file too, what do you think?

I think that we should add e.g. slaunch_lcp command and do not overload
slaunch_module command. However, I am not planning support for it in the
near feature. I mean I will not be working on it...

> Do not forget to apply changes required by latest Intel's platforms, you
> should check following commits in TBOOT's repository: 2f03b57ffdba,
> fe2dddd742dc.

Sure, will take that into account.

Thank you for your comments,

Daniel

PS By the way, I found an issue in TXT spec. TXT.VER.FSBIF refers to
   TXT.VER.EMIF which does not exist in spec. I suppose that it is
   remnant from previous TXT spec versions. It seems to me that it
   should be changed to TXT.VER.QPIIF. TXT.VER.QPIIF descriptions
   properly, IMO, refers back to TXT.VER.FSBIF.
