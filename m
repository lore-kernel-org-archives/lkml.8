Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350C7C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078CC2073D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAMHox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:44:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728558AbgAMHox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 02:44:53 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00D7gLot009159
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 02:44:52 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvvaa3nw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 02:44:51 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Mon, 13 Jan 2020 07:44:50 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Jan 2020 07:44:47 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00D7ijAO30539948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 07:44:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E65F0AE057;
        Mon, 13 Jan 2020 07:44:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF999AE055;
        Mon, 13 Jan 2020 07:44:43 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.202.21])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Jan 2020 07:44:43 +0000 (GMT)
Date:   Sun, 12 Jan 2020 23:44:40 -0800
From:   Ram Pai <linuxram@us.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, svaidy@linux.ibm.com, ego@linux.vnet.ibm.com,
        pratik.sampat@in.ibm.com, pratik.r.sampat@gmail.com
Subject: Re: [RESEND PATCH v2 1/3] powerpc/powernv: Interface to define
 support and preference for a SPR
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <cover.1578886602.git.psampat@linux.ibm.com>
 <926baad3fd0bf0b01b0adf83c71f2f4f6e9cf1e7.1578886602.git.psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <926baad3fd0bf0b01b0adf83c71f2f4f6e9cf1e7.1578886602.git.psampat@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 20011307-0008-0000-0000-00000348D974
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011307-0009-0000-0000-00004A6927A5
Message-Id: <20200113074440.GC5419@oc0525413822.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_01:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 09:15:07AM +0530, Pratik Rajesh Sampat wrote:
> Define a bitmask interface to determine support for the Self Restore,
> Self Save or both.
> 
> Also define an interface to determine the preference of that SPR to
> be strictly saved or restored or encapsulated with an order of preference.
> 
> The preference bitmask is shown as below:
> ----------------------------
> |... | 2nd pref | 1st pref |
> ----------------------------
> MSB			  LSB
> 
> The preference from higher to lower is from LSB to MSB with a shift of 8
> bits.
> Example:
> Prefer self save first, if not available then prefer self
> restore
> The preference mask for this scenario will be seen as below.
> ((SELF_RESTORE_STRICT << PREFERENCE_SHIFT) | SELF_SAVE_STRICT)
> ---------------------------------
> |... | Self restore | Self save |
> ---------------------------------
> MSB			        LSB
> 
> Finally, declare a list of preferred SPRs which encapsulate the bitmaks
> for preferred and supported with defaults of both being set to support
> legacy firmware.
> 
> This commit also implements using the above interface and retains the
> legacy functionality of self restore.
> 
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/idle.c | 327 +++++++++++++++++++++-----
>  1 file changed, 271 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 78599bca66c2..2f328403b0dc 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -32,9 +32,106 @@
>  #define P9_STOP_SPR_MSR 2000
>  #define P9_STOP_SPR_PSSCR      855
> 
> +/* Interface for the stop state supported and preference */
> +#define SELF_RESTORE_TYPE    0
> +#define SELF_SAVE_TYPE       1
> +
> +#define NR_PREFERENCES    2
> +#define PREFERENCE_SHIFT  4
> +#define PREFERENCE_MASK   0xf
> +
> +#define UNSUPPORTED         0x0
> +#define SELF_RESTORE_STRICT 0x1
> +#define SELF_SAVE_STRICT    0x2
> +
> +/*
> + * Bitmask defining the kind of preferences available.
> + * Note : The higher to lower preference is from LSB to MSB, with a shift of
> + * 4 bits.
> + * ----------------------------
> + * |    | 2nd pref | 1st pref |
> + * ----------------------------
> + * MSB			      LSB
> + */
> +/* Prefer Restore if available, otherwise unsupported */
> +#define PREFER_SELF_RESTORE_ONLY	SELF_RESTORE_STRICT
> +/* Prefer Save if available, otherwise unsupported */
> +#define PREFER_SELF_SAVE_ONLY		SELF_SAVE_STRICT
> +/* Prefer Restore when available, otherwise prefer Save */
> +#define PREFER_RESTORE_SAVE		((SELF_SAVE_STRICT << \
> +					  PREFERENCE_SHIFT)\
> +					  | SELF_RESTORE_STRICT)
> +/* Prefer Save when available, otherwise prefer Restore*/
> +#define PREFER_SAVE_RESTORE		((SELF_RESTORE_STRICT <<\
> +					  PREFERENCE_SHIFT)\
> +					  | SELF_SAVE_STRICT)
>  static u32 supported_cpuidle_states;
>  struct pnv_idle_states_t *pnv_idle_states;
>  int nr_pnv_idle_states;
> +/* Caching the lpcr & ptcr support to use later */
> +static bool is_lpcr_self_save;
> +static bool is_ptcr_self_save;
> +
> +struct preferred_sprs {
> +	u64 spr;
> +	u32 preferred_mode;
> +	u32 supported_mode;
> +};
> +
> +struct preferred_sprs preferred_sprs[] = {
> +	{
> +		.spr = SPRN_HSPRG0,
> +		.preferred_mode = PREFER_RESTORE_SAVE,
> +		.supported_mode = SELF_RESTORE_STRICT,
> +	},
> +	{
> +		.spr = SPRN_LPCR,
> +		.preferred_mode = PREFER_RESTORE_SAVE,
> +		.supported_mode = SELF_RESTORE_STRICT,
> +	},
> +	{
> +		.spr = SPRN_PTCR,
> +		.preferred_mode = PREFER_SAVE_RESTORE,
> +		.supported_mode = SELF_RESTORE_STRICT,
> +	},

This confuses me.  It says SAVE takes precedence over RESTORE.
and than it says it is strictly 'RESTORE' only.

Maybe you should not initialize the 'supported_mode' ?
or put a comment somewhere here, saying this value will be overwritten
during system initialization?


Otherwise the code looks correct.

Reviewed-by: Ram Pai <linuxram@us.ibm.com>
RP

