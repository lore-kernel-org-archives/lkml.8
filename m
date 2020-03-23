Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D680C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FFC20789
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hLDERQDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgCWMRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:17:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50598 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgCWMRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:17:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NC99M8189402;
        Mon, 23 Mar 2020 12:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=hfSMOXqACE8qzBauhvvDKiivyRgAyzlaa2dicrcsv2M=;
 b=hLDERQDdDh29S6VZwgkltZZnLePe9ZQeT5CYIGRyf8iny+iz0N+YqMRqhwjMqUHJ86PV
 KwDuNb66E5cl/5IVF2cJKrpDhMPJ5oNimDZ1Bhu4S0ETvZ/TDrHuCsdICgDA5JqQIxOU
 k7ASV/9qSHB5tS0woXWSdPmGP4YSqezX+p267YJqXs+Y9KCwBsyaWdLQzYFvJiSvSvJc
 IMa15xSJgU8dhMMMi6UsF40FgWtvop9b3TYxu5LquL83RPBDWKULuR2WbFNQ//aU8ZpS
 IGjhGxZaWdWBUPSgMa2YA93xEpq6oaR1+h4qdtFDI/NjB9OsbFJwgJNadJJXQKSR95Kf rQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ywavkx66c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 12:16:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NCGoXe092336;
        Mon, 23 Mar 2020 12:16:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ywvmvwbfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 12:16:54 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02NCGqwC020548;
        Mon, 23 Mar 2020 12:16:52 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Mar 2020 05:16:51 -0700
Date:   Mon, 23 Mar 2020 15:16:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, kan.liang@linux.intel.com,
        zhe.he@windriver.com, dzickus@redhat.com, jstancek@redhat.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf cpumap: Use scnprintf instead of snprintf
Message-ID: <20200323121642.GC4672@kadam>
References: <20200322172523.2677-1-christophe.jaillet@wanadoo.fr>
 <20200323110334.GC26299@kadam>
 <9f8351f9-7664-8c96-9c37-a6e86efc9643@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f8351f9-7664-8c96-9c37-a6e86efc9643@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 01:08:47PM +0100, Christophe JAILLET wrote:
> Le 23/03/2020 à 12:03, Dan Carpenter a écrit :
> > On Sun, Mar 22, 2020 at 06:25:23PM +0100, Christophe JAILLET wrote:
> > > 'scnprintf' returns the number of characters written in the output buffer
> > > excluding the trailing '\0', instead of the number of characters which
> > > would be generated for the given input.
> > > 
> > > Both function return a number of characters, excluding the trailing '\0'.
> > > So comparaison to check if it overflows, should be done against max_size-1.
> > > Comparaison against max_size can never match.
> > > 
> > > Fixes: 7780c25bae59f ("perf tools: Allow ability to map cpus to nodes easily")
> > > Fixes: a24020e6b7cf6 ("perf tools: Change cpu_map__fprintf output")
> > > Fixes: 92a7e1278005b ("perf cpumap: Add cpu__max_present_cpu()")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > >   tools/perf/util/cpumap.c | 39 ++++++++++++++++++++-------------------
> > >   1 file changed, 20 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > > index 983b7388f22b..b87e7ef4d130 100644
> > > --- a/tools/perf/util/cpumap.c
> > > +++ b/tools/perf/util/cpumap.c
> > > @@ -316,8 +316,8 @@ static void set_max_cpu_num(void)
> > >   		goto out;
> > >   	/* get the highest possible cpu number for a sparse allocation */
> > > -	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/possible", mnt);
> > > -	if (ret == PATH_MAX) {
> > > +	ret = scnprintf(path, PATH_MAX, "%s/devices/system/cpu/possible", mnt);
> > > +	if (ret == PATH_MAX-1) {
> > This should be a static analysis warning.
> > 
> > But isn't this stuff userspace?  I can't figure out how to compile it on
> > Debian so I'm not sure.  There is no scnprintf() in user space.
> > 
> > regards,
> > dan carpenter
> 
> I compiled it with:
> 
>     make tools/perf
> 

Ah.  You're absolutely right.  My bad.  Sorry for that.

I was doing "cd tools/perf; make" and it told me to install glibc-dev.

regards,
dan carpenter


