Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B62C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2618206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEFlD8sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390001AbgF2U5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:57:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24775 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731839AbgF2U5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593464235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXQKyufgPXhUo0Jq6KgGlFhHy0UGyfCM3CWYr/sTDJY=;
        b=jEFlD8srPMLXv5L6cGv6Gg7aR0OS2cX/aaNkA8qeh2lmalqKPSbl4VIIQ5wN85X6H9zUar
        JPv+h29drb5DDp3Lia/x9WQO7Qww+xxWh4gHtWLRhJv/0OONR3FIzn2YxN9JmjFNLHum8l
        Fu1ofMUw5Vr3vaD4I+V2zap1rGoJzms=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-ougWHY1LMuCbRwqQd7XWLg-1; Mon, 29 Jun 2020 16:57:10 -0400
X-MC-Unique: ougWHY1LMuCbRwqQd7XWLg-1
Received: by mail-ot1-f69.google.com with SMTP id x6so6924560otj.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yXQKyufgPXhUo0Jq6KgGlFhHy0UGyfCM3CWYr/sTDJY=;
        b=AnI3UbI1M6ByqpR/kmU4prOx188Zrw/mRgCpVOkgYeHXFlrfGUVUSm1CVmxAatxFsS
         wz2xusnI4YUZdqG8Pd50i+MqpVKBiCXAG+xiueocLKCN5LjPjb3Ji1eWcbhYzoQZXJd2
         e2ce3BYF5ugkrjo5/n8NPLBsuI94NPUYwK/0RFa/YbF/7IEc39Rmy5BLZ/hSCjUBmW5U
         G8X1BxrTJiEwBTD9dvtZB8n4UGvalmltHySIB7jrHKP8mZMWgtPK2LUg3KCPOonF6lzO
         InmdoU+yAVRhpYstWvORROpqJYICeA7f/gYYPusjfJiSqWFB17N7frfBBz25Vao3Xih7
         ielw==
X-Gm-Message-State: AOAM533nkVemfk55f9B5hKJBhNBboJFD5MVBa69ONrc2Ff1MILOqnmlI
        TVslb1zqqh4o8HGbF4K28RO/8er/49b4D4O7ya4x8/aDge2FrWNnDlHv91APnBKucyLvcksoSdk
        V9CtuOW044PGYrwkaEt5ccUJE
X-Received: by 2002:aca:4d11:: with SMTP id a17mr4409700oib.93.1593464230006;
        Mon, 29 Jun 2020 13:57:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy50dTvP8getMLG9WKIZFKpGpouEipqrXwVaD5gR2GF1XOftPXBRyPQOyrnXYhVsmxqF0/wA==
X-Received: by 2002:aca:4d11:: with SMTP id a17mr4409684oib.93.1593464229695;
        Mon, 29 Jun 2020 13:57:09 -0700 (PDT)
Received: from localhost (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id n128sm193358oih.33.2020.06.29.13.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 13:57:09 -0700 (PDT)
Date:   Mon, 29 Jun 2020 14:57:08 -0600
From:   Al Stone <ahs3@redhat.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
Subject: Re: [PATCH v4 2/2] ACPICA: Preserve memory opregion mappings
Message-ID: <20200629205708.GK1237914@redhat.com>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2788992.3K7huLjdjL@kreacher>
 <1666722.UopIai5n7p@kreacher>
 <1794490.F2OrUDcHQn@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1794490.F2OrUDcHQn@kreacher>
User-Agent: Mutt/1.14.0 (2020-05-02)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jun 2020 18:33, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The ACPICA's strategy with respect to the handling of memory mappings
> associated with memory operation regions is to avoid mapping the
> entire region at once which may be problematic at least in principle
> (for example, it may lead to conflicts with overlapping mappings
> having different attributes created by drivers).  It may also be
> wasteful, because memory opregions on some systems take up vast
> chunks of address space while the fields in those regions actually
> accessed by AML are sparsely distributed.
> 
> For this reason, a one-page "window" is mapped for a given opregion
> on the first memory access through it and if that "window" does not
> cover an address range accessed through that opregion subsequently,
> it is unmapped and a new "window" is mapped to replace it.  Next,
> if the new "window" is not sufficient to acess memory through the
> opregion in question in the future, it will be replaced with yet
> another "window" and so on.  That may lead to a suboptimal sequence
> of memory mapping and unmapping operations, for example if two fields
> in one opregion separated from each other by a sufficiently wide
> chunk of unused address space are accessed in an alternating pattern.
> 
> The situation may still be suboptimal if the deferred unmapping
> introduced previously is supported by the OS layer.  For instance,
> the alternating memory access pattern mentioned above may produce
> a relatively long list of mappings to release with substantial
> duplication among the entries in it, which could be avoided if
> acpi_ex_system_memory_space_handler() did not release the mapping
> used by it previously as soon as the current access was not covered
> by it.
> 
> In order to improve that, modify acpi_ex_system_memory_space_handler()
> to preserve all of the memory mappings created by it until the memory
> regions associated with them go away.
> 
> Accordingly, update acpi_ev_system_memory_region_setup() to unmap all
> memory associated with memory opregions that go away.
> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpica/evrgnini.c | 14 ++++----
>  drivers/acpi/acpica/exregion.c | 65 ++++++++++++++++++++++++----------
>  include/acpi/actypes.h         | 12 +++++--
>  3 files changed, 64 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
> index aefc0145e583..89be3ccdad53 100644
> --- a/drivers/acpi/acpica/evrgnini.c
> +++ b/drivers/acpi/acpica/evrgnini.c
> @@ -38,6 +38,7 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
>  	union acpi_operand_object *region_desc =
>  	    (union acpi_operand_object *)handle;
>  	struct acpi_mem_space_context *local_region_context;
> +	struct acpi_mem_mapping *mm;
>  
>  	ACPI_FUNCTION_TRACE(ev_system_memory_region_setup);
>  
> @@ -46,13 +47,14 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
>  			local_region_context =
>  			    (struct acpi_mem_space_context *)*region_context;
>  
> -			/* Delete a cached mapping if present */
> +			/* Delete memory mappings if present */
>  
> -			if (local_region_context->mapped_length) {
> -				acpi_os_unmap_memory(local_region_context->
> -						     mapped_logical_address,
> -						     local_region_context->
> -						     mapped_length);
> +			while (local_region_context->first_mm) {
> +				mm = local_region_context->first_mm;
> +				local_region_context->first_mm = mm->next_mm;
> +				acpi_os_unmap_memory(mm->logical_address,
> +						     mm->length);
> +				ACPI_FREE(mm);
>  			}
>  			ACPI_FREE(local_region_context);
>  			*region_context = NULL;
> diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
> index d15a66de26c0..fd68f2134804 100644
> --- a/drivers/acpi/acpica/exregion.c
> +++ b/drivers/acpi/acpica/exregion.c
> @@ -41,6 +41,7 @@ acpi_ex_system_memory_space_handler(u32 function,
>  	acpi_status status = AE_OK;
>  	void *logical_addr_ptr = NULL;
>  	struct acpi_mem_space_context *mem_info = region_context;
> +	struct acpi_mem_mapping *mm = mem_info->cur_mm;
>  	u32 length;
>  	acpi_size map_length;

I think this needs to be:

        acpi_size map_length = mem_info->length;

since it now gets used in the ACPI_ERROR() call below.  I'm getting
a "maybe used unitialized" error on compilation.

>  	acpi_size page_boundary_map_length;
> @@ -96,20 +97,38 @@ acpi_ex_system_memory_space_handler(u32 function,
>  	 * Is 1) Address below the current mapping? OR
>  	 *    2) Address beyond the current mapping?
>  	 */
> -	if ((address < mem_info->mapped_physical_address) ||
> -	    (((u64) address + length) > ((u64)
> -					 mem_info->mapped_physical_address +
> -					 mem_info->mapped_length))) {
> +	if (!mm || (address < mm->physical_address) ||
> +	    ((u64) address + length > (u64) mm->physical_address + mm->length)) {
>  		/*
> -		 * The request cannot be resolved by the current memory mapping;
> -		 * Delete the existing mapping and create a new one.
> +		 * The request cannot be resolved by the current memory mapping.
> +		 *
> +		 * Look for an existing saved mapping covering the address range
> +		 * at hand.  If found, save it as the current one and carry out
> +		 * the access.
>  		 */
> -		if (mem_info->mapped_length) {
> +		for (mm = mem_info->first_mm; mm; mm = mm->next_mm) {
> +			if (mm == mem_info->cur_mm)
> +				continue;
> +
> +			if (address < mm->physical_address)
> +				continue;
> +
> +			if ((u64) address + length >
> +					(u64) mm->physical_address + mm->length)
> +				continue;
>  
> -			/* Valid mapping, delete it */
> +			mem_info->cur_mm = mm;
> +			goto access;
> +		}
>  
> -			acpi_os_unmap_memory(mem_info->mapped_logical_address,
> -					     mem_info->mapped_length);
> +		/* Create a new mappings list entry */
> +		mm = ACPI_ALLOCATE_ZEROED(sizeof(*mm));
> +		if (!mm) {
> +			ACPI_ERROR((AE_INFO,
> +				    "Unable to save memory mapping at 0x%8.8X%8.8X, size %u",
> +				    ACPI_FORMAT_UINT64(address),
> +				    (u32)map_length));
> +			return_ACPI_STATUS(AE_NO_MEMORY);
>  		}
>  
>  		/*
> @@ -143,29 +162,39 @@ acpi_ex_system_memory_space_handler(u32 function,
>  
>  		/* Create a new mapping starting at the address given */
>  
> -		mem_info->mapped_logical_address =
> -		    acpi_os_map_memory(address, map_length);
> -		if (!mem_info->mapped_logical_address) {
> +		logical_addr_ptr = acpi_os_map_memory(address, map_length);
> +		if (!logical_addr_ptr) {
>  			ACPI_ERROR((AE_INFO,
>  				    "Could not map memory at 0x%8.8X%8.8X, size %u",
>  				    ACPI_FORMAT_UINT64(address),
>  				    (u32)map_length));
> -			mem_info->mapped_length = 0;
> +			ACPI_FREE(mm);
>  			return_ACPI_STATUS(AE_NO_MEMORY);
>  		}
>  
>  		/* Save the physical address and mapping size */
>  
> -		mem_info->mapped_physical_address = address;
> -		mem_info->mapped_length = map_length;
> +		mm->logical_address = logical_addr_ptr;
> +		mm->physical_address = address;
> +		mm->length = map_length;
> +
> +		/*
> +		 * Add the new entry to the mappigs list and save it as the
> +		 * current mapping.
> +		 */
> +		mm->next_mm = mem_info->first_mm;
> +		mem_info->first_mm = mm;
> +
> +		mem_info->cur_mm = mm;
>  	}
>  
> +access:
>  	/*
>  	 * Generate a logical pointer corresponding to the address we want to
>  	 * access
>  	 */
> -	logical_addr_ptr = mem_info->mapped_logical_address +
> -	    ((u64) address - (u64) mem_info->mapped_physical_address);
> +	logical_addr_ptr = mm->logical_address +
> +		((u64) address - (u64) mm->physical_address);
>  
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  			  "System-Memory (width %u) R/W %u Address=%8.8X%8.8X\n",
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index aa236b9e6f24..d005e35ab399 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -1201,12 +1201,18 @@ struct acpi_pci_id {
>  	u16 function;
>  };
>  
> +struct acpi_mem_mapping {
> +	acpi_physical_address physical_address;
> +	u8 *logical_address;
> +	acpi_size length;
> +	struct acpi_mem_mapping *next_mm;
> +};
> +
>  struct acpi_mem_space_context {
>  	u32 length;
>  	acpi_physical_address address;
> -	acpi_physical_address mapped_physical_address;
> -	u8 *mapped_logical_address;
> -	acpi_size mapped_length;
> +	struct acpi_mem_mapping *cur_mm;
> +	struct acpi_mem_mapping *first_mm;
>  };
>  
>  /*
> -- 
> 2.26.2
> 
> 
> 
> 

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------

