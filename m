Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6EBC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3182124964
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vpGLwNo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEGKrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:47:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45664 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgEGKrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:47:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047AhlNA049902;
        Thu, 7 May 2020 10:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=c3CT9d7CDjZqtfY6ltfhI8CLldAp3bjyJVEydg/d3JI=;
 b=vpGLwNo68nsXm6+kzsauk1wvfyn7kVttgfQSGLofSP8wwoVj7QhgnMp8UHL0PSQRbAbs
 hSlHd7TmkI2F6DsGY82hJnMxMjgkDWl8IUCMQBrW6thk/biyS8wFBMj9ylE8sZvwyMta
 eHP1jKoBXPijgc2mNo10mVy0+qyJSuDeU4tyYyVYLCF6qtWYrqBsFE+k0c/LgHw7+vIW
 SQT3JA1qT+rM8reoVGBfFRGJ6AJ4ZJhbWdHjJfl7JAsrWpoADLR09BXlCK4kXLEpHi1P
 R+Fa5WTqdGlQOv3sM597AMHpW7DEMwPAgzSLKgTdk01zgXJ56gJ66ZYyFo3VHrzrgnn5 Nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30veckgrus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 10:46:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047AforU173085;
        Thu, 7 May 2020 10:46:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30t1ra9vr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 10:46:35 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 047AkWhd030336;
        Thu, 7 May 2020 10:46:32 GMT
Received: from tomti.i.net-space.pl (/10.175.171.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 03:46:31 -0700
Date:   Thu, 7 May 2020 12:46:25 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     The development of GNU GRUB <grub-devel@gnu.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trenchboot-devel@googlegroups.com,
        the arch/x86 maintainers <x86@kernel.org>,
        alexander.burmashev@oracle.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        eric.snowberg@oracle.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, lukasz.hawrylko@linux.intel.com,
        michal.zygowski@3mdeb.com,
        "Vladimir 'phcoder' Serbinenko" <phcoder@gmail.com>,
        pirot.krol@3mdeb.com, Peter Jones <pjones@redhat.com>,
        Ross Philipson <ross.philipson@oracle.com>
Subject: Re: [GRUB PATCH RFC 12/18] i386/efi: Report UEFI Secure Boot status
 to the Linux kernel
Message-ID: <20200507104625.dmzqu5ntkdoir7ju@tomti.i.net-space.pl>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
 <20200504232132.23570-13-daniel.kiper@oracle.com>
 <CACdnJuszO1_aNXdgKt0_5XigC-AeuBT=gKkECszk7xX2p2TpkA@mail.gmail.com>
 <20200506133306.xrzplgdt4cckgrqc@tomti.i.net-space.pl>
 <CACdnJuvsx_sRG=TAQzcgF6E+xdpcR_e0QURH6AnBSwJxVbOE1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJuvsx_sRG=TAQzcgF6E+xdpcR_e0QURH6AnBSwJxVbOE1A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 11:36:49AM -0700, Matthew Garrett wrote:
> On Wed, May 6, 2020 at 6:33 AM Daniel Kiper <daniel.kiper@oracle.com> wrote:
> >
> > On Tue, May 05, 2020 at 10:29:05AM -0700, Matthew Garrett wrote:
> > > On Mon, May 4, 2020 at 4:25 PM Daniel Kiper <daniel.kiper@oracle.com> wrote:
> > > >
> > > > Otherwise the kernel does not know its state and cannot enable various
> > > > security features depending on UEFI Secure Boot.
> > >
> > > I think this needs more context. If the kernel is loaded via the EFI
> > > boot stub, the kernel is aware of the UEFI secure boot state. Why
> > > duplicate this functionality in order to avoid the EFI stub?
> >
> > It seems to me that this issue was discussed here [1] and here [2].
> > So, if you want me to improve the commit message I am OK with that.
>
> Yes, I think just providing an explanation for why it's currently
> necessary for you to duplicate this is reasonable.

Sure, will do!

Daniel
