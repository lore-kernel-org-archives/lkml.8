Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F77C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D624206F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgGTQuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:50:32 -0400
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:44054 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728495AbgGTQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:50:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C62BE1802DA32;
        Mon, 20 Jul 2020 16:50:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tree55_401562926f26
X-Filterd-Recvd-Size: 2217
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Mon, 20 Jul 2020 16:50:28 +0000 (UTC)
Message-ID: <613577badc9937049d40ff14d11646f64b3dac36.camel@perches.com>
Subject: Re: [PATCH 5.4 047/215] iio:humidity:hdc100x Fix alignment and data
 leak issues
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Mon, 20 Jul 2020 09:50:26 -0700
In-Reply-To: <20200720152822.437100100@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
         <20200720152822.437100100@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-20 at 17:35 +0200, Greg Kroah-Hartman wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> commit ea5e7a7bb6205d24371373cd80325db1bc15eded upstream.
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data.
> This data is allocated with kzalloc so no data can leak apart
> from previous readings.
[]
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -38,6 +38,11 @@ struct hdc100x_data {
>  
>  	/* integration time of the sensor */
>  	int adc_int_us[2];
> +	/* Ensure natural alignment of timestamp */
> +	struct {
> +		__be16 channels[2];
> +		s64 ts __aligned(8);

Why does an s64 need __aligned(8) ?
This seems needlessly redundant.

Isn't this naturally aligned by the compiler?

The struct isn't packed.

