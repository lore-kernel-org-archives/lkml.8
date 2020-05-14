Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337B7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDAB20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgENS65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:58:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729915AbgENS6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:58:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EIdSpF055409;
        Thu, 14 May 2020 14:58:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3101kq446q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 14:58:21 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04EImK2Y079555;
        Thu, 14 May 2020 14:58:21 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3101kq4468-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 14:58:21 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04EIonLD013393;
        Thu, 14 May 2020 18:58:20 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 3100ubrvft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 18:58:20 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04EIwJ2Q30409116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 18:58:19 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDB922805C;
        Thu, 14 May 2020 18:58:19 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6748E28058;
        Thu, 14 May 2020 18:58:19 +0000 (GMT)
Received: from localhost (unknown [9.85.205.196])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 14 May 2020 18:58:19 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v3 2/2] powerpc/rtas: Implement reentrant rtas call
In-Reply-To: <20200514011245.127174-3-leobras.c@gmail.com>
References: <20200514011245.127174-1-leobras.c@gmail.com> <20200514011245.127174-3-leobras.c@gmail.com>
Date:   Thu, 14 May 2020 13:58:18 -0500
Message-ID: <878shu2vjp.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_06:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 cotscore=-2147483648 mlxlogscore=999 adultscore=0 clxscore=1011
 suspectscore=1 spamscore=0 phishscore=0 priorityscore=1501 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Leonardo Bras <leobras.c@gmail.com> writes:
> +/**
> + * rtas_call_reentrant() - Used for reentrant rtas calls
> + * @token:	Token for desired reentrant RTAS call
> + * @nargs:	Number of Input Parameters
> + * @nret:	Number of Output Parameters
> + * @outputs:	Array of outputs
> + * @...:	Inputs for desired RTAS call
> + *
> + * According to LoPAR documentation, only "ibm,int-on", "ibm,int-off",
> + * "ibm,get-xive" and "ibm,set-xive" are currently reentrant.
> + * Reentrant calls need their own rtas_args buffer, so not using rtas.args, but
> + * PACA one instead.
> + *
> + * Return:	-1 on error,
> + *		First output value of RTAS call if (nret > 0),
> + *		0 otherwise,
> + */
> +
> +int rtas_call_reentrant(int token, int nargs, int nret, int *outputs, ...)
> +{
> +	va_list list;
> +	struct rtas_args *args;
> +	int i;
> +
> +	if (!rtas.entry || token == RTAS_UNKNOWN_SERVICE)
> +		return -1;
> +
> +	/* We use the per-cpu (PACA) rtas args buffer */
> +	args = &local_paca->reentrant_args;
> +
> +	va_start(list, outputs);
> +	va_rtas_call_unlocked(args, token, nargs, nret, list);
> +	va_end(list);
> +
> +	if (nret > 1 && outputs)
> +		for (i = 0; i < nret - 1; ++i)
> +			outputs[i] = be32_to_cpu(args->rets[i + 1]);

Doesn't this need to be more careful about preemption and exceptions?
I.e. the args structure in the paca needs to be protected from
concurrent use somehow, like any per-cpu data structure.

local_irq_save/restore while accessing local_paca->reentrant_args here
would be sufficient I think?
