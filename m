Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A10C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCDB2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="POqSritt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCZNlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:41:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46064 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZNlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:41:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QDdON6026557;
        Thu, 26 Mar 2020 13:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=47kOGG+bdoJaXnP8m/osKaGZ0uajF8a3MGNKMsop3vY=;
 b=POqSrittxnwjNutlDxb96joCHnJG44Uwn0rAnWaPePWcbKl24WTa/fHu8MBJbYxX/DUI
 1Lgrt4Gy6uxnHBYL0Gm3CfnKJCAnlnKAAZcjgmKYbiTcXy6T91ziidi0vYCGLM1S8wCy
 KKpWPeiXFX5tZ+Z8R0DeA/NGhu6u9SJJK681d4nzOCTO0rDrsYOc2IdwViUO263hlfxS
 UnGr2W57gQ3+rYanhvGnx8N5+fe+ny+8YNBDQPgKeh/7A345gyVLVMQI7+F9GbPyMVub
 gXLxxklYBHLI5p2QUrWpzSYpviHg6mPJbJVfRNhgsIyOLgl67JL/4RtTn6gJaxAMxdmS mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ywabrfun5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 13:40:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QDVgiS000938;
        Thu, 26 Mar 2020 13:40:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3003gkvkmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 13:40:23 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02QDeHrF000682;
        Thu, 26 Mar 2020 13:40:18 GMT
Received: from tomti.i.net-space.pl (/10.175.206.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 06:40:17 -0700
Date:   Thu, 26 Mar 2020 14:40:11 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        trenchboot-devel@googlegroups.com, ardb@kernel.org,
        leif@nuviainc.com, eric.snowberg@oracle.com, piotr.krol@3mdeb.com,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        james.bottomley@hansenpartnership.com, andrew.cooper3@citrix.com
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux
 kernel support
Message-ID: <20200326134011.c4dswiq2g7eln3qd@tomti.i.net-space.pl>
References: <20200325194317.526492-1-ross.philipson@oracle.com>
 <CACdnJut56WuqO=uLff0qy1Jp=C6f_sRxLpRBsrzb6byBsFYdCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACdnJut56WuqO=uLff0qy1Jp=C6f_sRxLpRBsrzb6byBsFYdCg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

CC-in Ard, Leif, Eric, Piotr, Krystian, Michał, James and Andrew...

On Wed, Mar 25, 2020 at 01:29:03PM -0700, 'Matthew Garrett' via trenchboot-devel wrote:
> On Wed, Mar 25, 2020 at 12:43 PM Ross Philipson
> <ross.philipson@oracle.com> wrote:
> > To enable the kernel to be launched by GETSEC or SKINIT, a stub must be
> > built into the setup section of the compressed kernel to handle the
> > specific state that the late launch process leaves the BSP. This is a
> > lot like the EFI stub that is found in the same area. Also this stub
> > must measure everything that is going to be used as early as possible.
> > This stub code and subsequent code must also deal with the specific
> > state that the late launch leaves the APs in.
>
> How does this integrate with the EFI entry point? That's the expected

It does not. We do not want and need to tie secure launch with UEFI.

> entry point on most modern x86.

Yeah, most but not all...

> What's calling ExitBootServices() in

Currently it is a bootloader, the GRUB which I am working on... OK, this
is not perfect but if we want to call ExitBootServices() from the kernel
then we have to move all pre-launch code from the bootloader to the
kernel. Not nice because then everybody who wants to implement secure
launch in different kernel, hypervisor, etc. has to re-implement whole
pre-launch code again.

> this flow, and does the secure launch have to occur after it? It'd be

Yes, it does.

> a lot easier if you could still use the firmware's TPM code rather
> than carrying yet another copy.

I think any post-launch code in the kernel should not call anything from
the gap. And UEFI belongs to the gap. OK, we can potentially re-use UEFI
TPM code in the pre-launch phase but I am not convinced that we should
(I am looking at it right now). And this leads us to other question
which pops up here and there. How to call UEFI runtime services, e.g. to
modify UEFI variables, update firmware, etc., from MLE or even from the
OS started from MLE? In my opinion it is not safe to call anything from
the gap after secure launch. However, on the other hand we have to give
an option to change the boot order or update the firmware. So, how to
do that? I do not have an easy answer yet...

Daniel
