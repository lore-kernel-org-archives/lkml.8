Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218E7C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19EF24671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgAOOX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:23:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbgAOOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:23:27 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FENNu0139563
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 09:23:26 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhbvgehq7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 09:23:22 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 15 Jan 2020 14:21:04 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 Jan 2020 14:21:01 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00FEL0VD43909150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 14:21:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75CA1A4060;
        Wed, 15 Jan 2020 14:21:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D96C4A4064;
        Wed, 15 Jan 2020 14:20:59 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.8.170])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Jan 2020 14:20:59 +0000 (GMT)
Date:   Wed, 15 Jan 2020 16:20:58 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        keescook@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] init/main.c: make some symbols static
References: <20200115135458.71460-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115135458.71460-1-chenzhou10@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 20011514-0016-0000-0000-000002DD909C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011514-0017-0000-0000-00003340240E
Message-Id: <20200115142057.GE19826@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_02:2020-01-15,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001150116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(added Steven and Masami)

On Wed, Jan 15, 2020 at 09:54:58PM +0800, Chen Zhou wrote:
> Make variable xbc_namebuf and function boot_config_checksum static to
> fix build warnings, warnings are as follows:
> 
> init/main.c:254:6:
> 	warning: symbol 'xbc_namebuf' was not declared. Should it be static?
> init/main.c:330:5:
> 	warning: symbol 'boot_config_checksum' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  init/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index a77114f..3a95591 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -251,7 +251,7 @@ early_param("loglevel", loglevel);
>  
>  #ifdef CONFIG_BOOT_CONFIG
>  
> -char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
> +static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
>  
>  #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
>  
> @@ -327,7 +327,7 @@ static char * __init xbc_make_cmdline(const char *key)
>  	return new_cmdline;
>  }
>  
> -u32 boot_config_checksum(unsigned char *p, u32 size)
> +static u32 boot_config_checksum(unsigned char *p, u32 size)
>  {
>  	u32 ret = 0;
>  
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.

