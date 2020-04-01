Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD0DC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6860B20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbgDAJ66 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:58:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726335AbgDAJ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:58:58 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0319Xlxc112731
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 05:58:57 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304hja3n8q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 05:58:57 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Wed, 1 Apr 2020 10:58:39 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 10:58:36 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0319wpZM54263828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 09:58:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DEE5AE053;
        Wed,  1 Apr 2020 09:58:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EFF6AE04D;
        Wed,  1 Apr 2020 09:58:51 +0000 (GMT)
Received: from localhost (unknown [9.85.74.146])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 09:58:50 +0000 (GMT)
Date:   Wed, 01 Apr 2020 15:28:48 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 6/6] pseries/sysfs: Minimise IPI noise while reading
 [idle_][s]purr
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1585308760-28792-1-git-send-email-ego@linux.vnet.ibm.com>
        <1585308760-28792-7-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1585308760-28792-7-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20040109-0020-0000-0000-000003BF864F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040109-0021-0000-0000-000022182B57
Message-Id: <1585734367.oqwn7dzljo.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently purr, spurr, idle_purr, idle_spurr are exposed for every CPU
> via the sysfs interface
> /sys/devices/system/cpu/cpuX/[idle_][s]purr. Each sysfs read currently
> generates an IPI to obtain the desired value from the target CPU X.
> Since these aforementioned sysfs are typically read one after another,
> we end up generating 4 IPIs per CPU in a short duration.
> 
> In order to minimize the IPI noise, this patch caches the values of
> all the four entities whenever one of them is read. If subsequently
> any of these are read within the next 10ms, the cached value is
> returned. With this, we will generate at most one IPI every 10ms for
> every CPU.
> 
> Test-results: While reading the four sysfs files back-to-back for a
> given CPU every second for 100 seconds.
> 
> Without the patch:
> 		 16 [XICS 2 Edge IPI] = 422 times
> 		 DBL [Doorbell interrupts] = 13 times
> 		 Total : 435 IPIs.
> 
> With the patch:
> 		  16 [XICS 2 Edge IPI] = 111 times
> 		  DBL [Doorbell interrupts] = 17 times
> 		  Total : 128 IPIs.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/sysfs.c | 117 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 97 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 571b325..bd92023 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -586,8 +586,6 @@ void ppc_enable_pmcs(void)
>   * SPRs which are not related to PMU.
>   */
>  #ifdef CONFIG_PPC64
> -SYSFS_SPRSETUP(purr, SPRN_PURR);
> -SYSFS_SPRSETUP(spurr, SPRN_SPURR);
>  SYSFS_SPRSETUP(pir, SPRN_PIR);
>  SYSFS_SPRSETUP(tscr, SPRN_TSCR);
> 
> @@ -596,8 +594,6 @@ void ppc_enable_pmcs(void)
>    enable write when needed with a separate function.
>    Lets be conservative and default to pseries.
>  */
> -static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
> -static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
>  static DEVICE_ATTR(pir, 0400, show_pir, NULL);
>  static DEVICE_ATTR(tscr, 0600, show_tscr, store_tscr);
>  #endif /* CONFIG_PPC64 */
> @@ -761,22 +757,110 @@ static void create_svm_file(void)
>  }
>  #endif /* CONFIG_PPC_SVM */
> 
> +#ifdef CONFIG_PPC64
> +/*
> + * The duration (in ms) from the last IPI to the target CPU until
> + * which a cached value of purr, spurr, idle_purr, idle_spurr can be
> + * reported to the user on a corresponding sysfs file read. Beyond
> + * this duration, fresh values need to be obtained by sending IPIs to
> + * the target CPU when the sysfs files are read.
> + */
> +static unsigned long util_stats_staleness_tolerance_ms = 10;

This is a nice optimization for our use in lparstat, though I have a 
concern below.

> +struct util_acct_stats {
> +	u64 latest_purr;
> +	u64 latest_spurr;
> +#ifdef CONFIG_PPC_PSERIES
> +	u64 latest_idle_purr;
> +	u64 latest_idle_spurr;
> +#endif

You can probably drop the 'latest_' prefix.

> +	unsigned long last_update_jiffies;
> +};
> +
> +DEFINE_PER_CPU(struct util_acct_stats, util_acct_stats);

Per snowpatch, this should be static, and so should get_util_stats_ptr() 
below:
https://openpower.xyz/job/snowpatch/job/snowpatch-linux-sparse/16601//artifact/linux/report.txt

> +
> +static void update_util_acct_stats(void *ptr)
> +{
> +	struct util_acct_stats *stats = ptr;
> +
> +	stats->latest_purr = mfspr(SPRN_PURR);
> +	stats->latest_spurr = mfspr(SPRN_SPURR);
>  #ifdef CONFIG_PPC_PSERIES
> -static void read_idle_purr(void *val)
> +	stats->latest_idle_purr = read_this_idle_purr();
> +	stats->latest_idle_spurr = read_this_idle_spurr();
> +#endif
> +	stats->last_update_jiffies = jiffies;
> +}
> +
> +struct util_acct_stats *get_util_stats_ptr(int cpu)
> +{
> +	struct util_acct_stats *stats = per_cpu_ptr(&util_acct_stats, cpu);
> +	unsigned long delta_jiffies;
> +
> +	delta_jiffies = jiffies - stats->last_update_jiffies;
> +
> +	/*
> +	 * If we have a recent enough data, reuse that instead of
> +	 * sending an IPI.
> +	 */
> +	if (jiffies_to_msecs(delta_jiffies) < util_stats_staleness_tolerance_ms)
> +		return stats;
> +
> +	smp_call_function_single(cpu, update_util_acct_stats, stats, 1);
> +	return stats;
> +}
> +
> +static ssize_t show_purr(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
>  {
> -	u64 *ret = val;
> +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> +	struct util_acct_stats *stats;
> 
> -	*ret = read_this_idle_purr();
> +	stats = get_util_stats_ptr(cpu->dev.id);
> +	return sprintf(buf, "%llx\n", stats->latest_purr);

This alters the behavior of the current sysfs purr file. I am not sure 
if it is reasonable to return the same PURR value across a 10ms window.

I wonder if we should introduce a sysctl interface to control 
thresholding. It can default to 0, which disables thresholding so that 
the existing behavior continues. Applications (lparstat) can optionally 
set it to suit their use.

- Naveen

