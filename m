Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2305C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00952085B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588167337;
	bh=B8pSobiKyn8CUfQ+seeTjOXCyKoAE7PEkBa529ZuO9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bhu8Zk3TrCDGyoL3gH33PPgdzQ1VJ0odvvnqF3FhT+ncbeoO76EGlssSl0DLzmfvf
	 MKyuntGerCRYkbqaRHSOBmdeA1bLLUQpr6qgVkSd/XcdFpqzEz2GsKT1LwhsDx5sVe
	 bpiw3YjjYhDFgY0oMVb5AMxl1LAV8fyFZkDUJ3CA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgD2Nfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:35:37 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:52617 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgD2Nfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:35:36 -0400
Received: by mail-wm1-f46.google.com with SMTP id 188so2055647wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zVcMyyXgly8dcZ1W48/YJRsJdPDZ29G6svQLPAiabDU=;
        b=l7CiP0E5tOiPKMGBSKl2zi/RjIZJp0CHspE6MvAjKMidoI3tJjJftz33Od7lPEJbvM
         cOqLketS0uKZ+RhaiZLZCLJ5zspfMpWMjrSbLnmQAFj1Ms3JsXDKsnpm5dnEdBMks48w
         MGZQx0jpE2QOYrT2J0ARj/4zkjvG3MLc0a4FzXGL0KEch4vBMQBvY6l77GsjiocBXtqB
         KXTJvBx+VfSI0mV+nvAcVtD2g+bAkzMBh9c5j1LS7fbqItTH8PzhemIPEPmlpqSawWx7
         WjMHJTFcPvO4QTAH7oEdN9T6FQuRTMXEdIz6kn/A1QXNi+E3zJNRXt1FCzQxGLNz06fq
         rApg==
X-Gm-Message-State: AGi0Pubx0TsBLzTGVmg6pEvtco7kzyhCMZTxehVQQUenLqHU+zB7gH+1
        sw3IEIKHOjiFtr3uw5f4xJQ=
X-Google-Smtp-Source: APiQypIfI2Iu/A8rMm0AqpV0Ln7Plf5ZvMG4mOEGuK6Ja6mwzohrK5s6Wa1wqyfvDlvwJf2IjaOFDw==
X-Received: by 2002:a1c:c2d6:: with SMTP id s205mr3520417wmf.90.1588167334367;
        Wed, 29 Apr 2020 06:35:34 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id 138sm8249950wmb.14.2020.04.29.06.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 06:35:33 -0700 (PDT)
Date:   Wed, 29 Apr 2020 15:35:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vaneet Narang <v.narang@samsung.com>
Cc:     Maninder Singh <maninder1.s@samsung.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>
Subject: Re: (2) [PATCH 1/1] mm/vmscan.c: change prototype for
 shrink_page_list
Message-ID: <20200429133532.GF28637@dhcp22.suse.cz>
References: <20200429130912.GE28637@dhcp22.suse.cz>
 <20200429120951.GC28637@dhcp22.suse.cz>
 <1588139967-19012-1-git-send-email-maninder1.s@samsung.com>
 <20200429125323epcms5p67a539511c573cd598d78b726503e3204@epcms5p6>
 <CGME20200429055946epcas5p2d5faf2b320913d59a4a8380cb017053c@epcms5p8>
 <20200429132940epcms5p81e75e09469b62253ff512222c568556f@epcms5p8>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200429132940epcms5p81e75e09469b62253ff512222c568556f@epcms5p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-04-20 18:59:40, Vaneet Narang wrote:
> Hi Michal, 
> 
> >> >
> >> >Acked-by: Michal Hocko <mhocko@suse.com>
> >> >
> >> >Is there any reason to move declarations here?
> >> >
> >> 
> >> "unsigned int ret" was changed mistakenely, sending V2.
> >> and "unsigned int nr_reclaimed" is changed to remove hole.
>  
> >Could you be more specific? Have you seen a better stack allocation
> >footprint?
> 
> We didn't check stack allocation footprint, we did changes just by looking into the code.
> we thought changing reclaimed type from long to int on 64 bit platform will add 
> hole of 4 bytes between two stack variables nr_reclaimed & nr_taken.
> 
> So we tried to remove that hole by packing it with bool.
> 
>  	unsigned long nr_scanned;                 --> Size and alignment 8 byte for long 
> -	unsigned long nr_reclaimed = 0;           --> Changing to int will make its size as 4  
>  	unsigned long nr_taken;                   --> nr_taken needs alignment of 8 so will add hole.
>  	struct reclaim_stat stat;
>  	int file = is_file_lru(lru);
>  	enum vm_event_item item;
>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>  	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
> +	unsigned int nr_reclaimed = 0;            --> So moving to this place to pack it along with bool 
>  	bool stalled = false;
> 
> 
> Overall stack footprint might not change as compiler makes function stack pointer as 16 byte aligned but we did this 
> as we normally follow this coding convention when defining structures or stack variables. 

My understanding is that gcc can and does tricks when allocating space
for local variables. It can use registers and there is no dictated
structure on the placing of variable or ordering (unlike for
structures).

Anyway, I would prefer if the patch was doing one thing at the time.
If you can see some (have a look ./scripts/bloat-o-meter) improvements
from reordering, make it a separate patch with some numbers attached.
-- 
Michal Hocko
SUSE Labs
