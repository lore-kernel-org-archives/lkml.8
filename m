Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCF9C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03AB20637
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgBKNMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:12:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728697AbgBKNMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:12:33 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BD2VWE100388
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 08:12:32 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1tn3u2xh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 08:12:24 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Tue, 11 Feb 2020 13:12:14 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Feb 2020 13:12:11 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01BDCAtN21233696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 13:12:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3222FA4060;
        Tue, 11 Feb 2020 13:12:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C25C9A405F;
        Tue, 11 Feb 2020 13:12:09 +0000 (GMT)
Received: from localhost (unknown [9.145.77.145])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 11 Feb 2020 13:12:09 +0000 (GMT)
Date:   Tue, 11 Feb 2020 14:12:08 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] s390/time: Fix clk type in get_tod_clock
References: <20200208140858.47970-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200208140858.47970-1-natechancellor@gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 20021113-0008-0000-0000-00000351E012
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021113-0009-0000-0000-00004A72814C
Message-Id: <your-ad-here.call-01581426728-ext-3459@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_03:2020-02-10,2020-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 07:08:59AM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> In file included from ../arch/s390/boot/startup.c:3:
> In file included from ../include/linux/elf.h:5:
> In file included from ../arch/s390/include/asm/elf.h:132:
> In file included from ../include/linux/compat.h:10:
> In file included from ../include/linux/time.h:74:
> In file included from ../include/linux/time32.h:13:
> In file included from ../include/linux/timex.h:65:
> ../arch/s390/include/asm/timex.h:160:20: warning: passing 'unsigned char
> [16]' to parameter of type 'char *' converts between pointers to integer
> types with different sign [-Wpointer-sign]
>         get_tod_clock_ext(clk);
>                           ^~~
> ../arch/s390/include/asm/timex.h:149:44: note: passing argument to
> parameter 'clk' here
> static inline void get_tod_clock_ext(char *clk)
>                                            ^
> 
> Change clk's type to just be char so that it matches what happens in
> get_tod_clock_ext.
> 
> Fixes: 57b28f66316d ("[S390] s390_hypfs: Add new attributes")
> Link: https://github.com/ClangBuiltLinux/linux/issues/861
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Alternatively, changing the clk type in get_tod_clock_ext to unsigned
> which is what it was in the early 2000s.
> 
>  arch/s390/include/asm/timex.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
> index 670f14a228e5..6bf3a45ccfec 100644
> --- a/arch/s390/include/asm/timex.h
> +++ b/arch/s390/include/asm/timex.h
> @@ -155,7 +155,7 @@ static inline void get_tod_clock_ext(char *clk)
>  
>  static inline unsigned long long get_tod_clock(void)
>  {
> -	unsigned char clk[STORE_CLOCK_EXT_SIZE];
> +	char clk[STORE_CLOCK_EXT_SIZE];
>  
>  	get_tod_clock_ext(clk);
>  	return *((unsigned long long *)&clk[1]);
> -- 
> 2.25.0
> 
Applied, thanks.
I wonder though if Fixes: tag is really required for such changes. It
triggers stable backports (for all stable branches since v2.6.35) and
hence a lot of noise.

