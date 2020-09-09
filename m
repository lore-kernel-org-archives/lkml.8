Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E2BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E2B206F4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Z1M9ntol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgIIHwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:52:24 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:17040 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgIIHwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:52:14 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08975FBR016400;
        Wed, 9 Sep 2020 00:52:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=iYQzP7Po5e5NwxSiJzqN05/WoG8Ijh+5gf9FLTnk+HE=;
 b=Z1M9ntolSHxSc0Sk+hQwYlEfVxky1sEm0dIhkdbB+iNhDUR7zBOhtsZCrgwKT0a3WEBl
 znxgbXPYHYSW8UadMKRjW03Jap3g0Y/0J+LsBVXkeeVzIQ1ejP6iim5kLCr+sBJfplmm
 cDSKnl+vYLKsLTi3ey+WYPhS8L1xNfthWkuPga6Zbk9G+2wmf9KBllvgqU3yFqMQGQhE
 dwOsYOYq8jjblB8q5KcknvWGeKHnPY8rN8qGnfD8hWSRp1e4L8dD54tzPMR2k7QEye0d
 QWylE4mQ4d8cYUfadMwra5WGZyJUwLLSIhy/B73cznMR874iU6pxHY+wp1dx+Hc/c87x rQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 33c81pxvg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 00:52:01 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Sep
 2020 00:52:01 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Sep
 2020 00:52:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 00:52:00 -0700
Received: from [10.6.200.75] (NN-LT0019.marvell.com [10.6.200.75])
        by maili.marvell.com (Postfix) with ESMTP id 2D7B53F7043;
        Wed,  9 Sep 2020 00:51:57 -0700 (PDT)
Subject: Re: [EXT] [PATCH 2/5] scsi/qla2xxx: Convert to SPDX license
 identifiers
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-spdx@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20200908123451.7215-1-lukas.bulwahn@gmail.com>
 <20200908123451.7215-3-lukas.bulwahn@gmail.com>
From:   Igor Russkikh <irusskikh@marvell.com>
Message-ID: <81ef3e30-9245-f2f9-3a4f-cd644caed608@marvell.com>
Date:   Wed, 9 Sep 2020 10:51:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200908123451.7215-3-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_03:2020-09-08,2020-09-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Lukas, Thomas,

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> All files in this driver directory contain the following notice:
> 
>   See LICENSE.qla2xxx for copyright and licensing details.
> 
> LICENSE.qla2xxx can be found in Documentation/scsi/. The file contains:
> 
>   - A copyright notice
> 
>     This copyright notice is redundant as all files contain the same
>     copyright notice already
> 
>   - A license notice
> 
>     You may modify and redistribute the device driver code under the
>     GNU General Public License (a copy of which is attached hereto as
>     Exhibit A) published by the Free Software Foundation (version 2).
> 
>     This can be replaced with the corresponding SPDX license identifier
>     (GPL-2.0-only) in the source files which reference this license
>     file.
> 
>   - The full GPLv2 license text
> 
>     A redundant copy of LICENSES/preferred/GPL-2.0
> 
> Remove the notices and add the SPDX license identifier GPL-2.0-only to the
> source files.
> 
> Finally remove the now redundant LICENSE.qla2xxx file.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Richard Fontana <rfontana@redhat.com>
> Reviewed-by: Jilayne Lovejoy <opensource@jilayne.com>
> Reviewed-by: Alexios Zavras <alexios.zavras@intel.com>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Igor Russkikh <irusskikh@marvell.com>

