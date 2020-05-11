Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABFBC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 255D620736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huMNMqYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgEKLBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:01:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30630 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728136AbgEKLBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589194907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFDVkhRoHqXvQ6Q+8XkWGBWxZCbZLeL6G8I1FDsAcKI=;
        b=huMNMqYJN46cyRV6jtJobDr/Lr0lDnESjvF8bZtAafJ62TX4naY7+jfQ0YHPbk46tFhnJm
        6MCtJXDKIrr7t/hNO7/J//zKc0dGZiF2OlY3zAKKSrdtWoBlgrWA0xFHg46CZikU/rQBRQ
        CxMS6HjJV4EsWigJyAg0HshPra0VLpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-N-YvmnBvNaWFqTnrZdz2WA-1; Mon, 11 May 2020 07:01:44 -0400
X-MC-Unique: N-YvmnBvNaWFqTnrZdz2WA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9EFD460;
        Mon, 11 May 2020 11:01:41 +0000 (UTC)
Received: from krava (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4576D60FC2;
        Mon, 11 May 2020 11:01:38 +0000 (UTC)
Date:   Mon, 11 May 2020 13:01:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        qiangqing.zhang@nxp.com, irogers@google.com, robin.murphy@arm.com,
        zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v3 02/12] perf jevents: Add support for system events
 tables
Message-ID: <20200511110137.GC2986380@krava>
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
 <1588852671-61996-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588852671-61996-3-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:57:41PM +0800, John Garry wrote:

SNIP

> +				      &sys_event_tables);
> +		}
> +
>  		print_events_table_prefix(eventsfp, tblname);
>  		return 0;
>  	}
> @@ -1180,7 +1253,6 @@ int main(int argc, char *argv[])
>  	} else if (rc < 0) {
>  		/* Make build fail */
>  		fclose(eventsfp);
> -		free_arch_std_events();
>  		ret = 1;
>  		goto out_free_mapfile;
>  	} else if (rc) {
> @@ -1206,27 +1278,31 @@ int main(int argc, char *argv[])
>  	if (close_table)
>  		print_events_table_suffix(eventsfp);
>  
> -	if (!mapfile) {
> -		pr_info("%s: No CPU->JSON mapping?\n", prog);
> -		goto empty_map;
> +	if (mapfile) {
> +		if (process_mapfile(eventsfp, mapfile)) {
> +			pr_err("%s: Error processing mapfile %s\n", prog,
> +			       mapfile);
> +			/* Make build fail */
> +			fclose(eventsfp);
> +			ret = 1;
> +		}
> +	} else {
> +		pr_err("%s: No CPU->JSON mapping?\n", prog);

shouldn't we jump to empty_map in here? there still needs to be a
mapfile, right?

jirka

>  	}
>  
> -	if (process_mapfile(eventsfp, mapfile)) {
> -		pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
> -		/* Make build fail */
> +	if (process_system_event_tables(eventsfp)) {
>  		fclose(eventsfp);
> -		free_arch_std_events();
>  		ret = 1;
>  	}
>  
> -
>  	goto out_free_mapfile;
>  
>  empty_map:
>  	fclose(eventsfp);
>  	create_empty_mapping(output_file);
> -	free_arch_std_events();
>  out_free_mapfile:
> +	free_arch_std_events();
> +	free_sys_event_tables();
>  	free(mapfile);
>  	return ret;
>  }

SNIP

