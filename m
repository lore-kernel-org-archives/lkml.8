Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2087C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B61B1206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgIGPAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:00:46 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:2715 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730056AbgIGOxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:53:39 -0400
Subject: Re: [PATCH v7 3/3] binder: add transaction latency tracer
To:     Frankie Chang <Frankie.Chang@mediatek.com>,
        Todd Kjos <tkjos@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
References: <1596509145.5207.21.camel@mtkswgap22>
 <1596549552-5466-1-git-send-email-Frankie.Chang@mediatek.com>
 <1596549552-5466-4-git-send-email-Frankie.Chang@mediatek.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <f8ff8cb2-913d-c009-53a4-2918ce923a89@sony.com>
Date:   Mon, 7 Sep 2020 16:41:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596549552-5466-4-git-send-email-Frankie.Chang@mediatek.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=FfdJO626 c=1 sm=1 tr=0 a=CGteIMthFL3x4Fb36c5kWA==:117 a=IkcTkHD0fZMA:10 a=reM5J-MqmosA:10 a=9zETfiKQeoRBRZLemOoA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/20 3:59 PM, Frankie Chang wrote:
> +void probe_binder_txn_latency_free(void *ignore, struct binder_transaction *t,
> +					int from_proc, int from_thread,
> +					int to_proc, int to_thread)
> +{
> +	struct rtc_time tm;
> +	struct timespec64 *startime;
> +	struct timespec64 cur, sub_t;
> +
> +	ktime_get_ts64(&cur);


I think sched_clock is what you want.


> +	startime = &t->timestamp;
> +	sub_t = timespec64_sub(cur, *startime);
> +
> +	/* if transaction time is over than binder_txn_latency_threshold (sec),
> +	 * show timeout warning log.
> +	 */
> +	if (sub_t.tv_sec < binder_txn_latency_threshold)
> +		return;
> +
> +	rtc_time_to_tm(t->tv.tv_sec, &tm);

