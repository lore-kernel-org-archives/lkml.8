Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEB8C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3526A2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnJXZpl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504314AbgDPJw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:52:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26130 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2504220AbgDPJwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587030715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=gitbw/LDz8zvzkhQtIGPdeeZtaGhCIB6m0kKyH6MDAY=;
        b=BnJXZpl3MA49ducp3a/G3s12X5Y2bIRmBh6oRypqAYDZWPCn5p1zGaxVz4IwHERuSBGw5q
        1r3rnm0yfJccXVrJrBuw+c4MKOZWui6crN51GZ7aBlEJTHsQAcojZ2I+C7mRDNn42TRAh7
        XYeuJKO84PB2byxJtl5dBNvc2776fI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-Ub2sNWH4MemAqFOUSMmQ8w-1; Thu, 16 Apr 2020 05:51:53 -0400
X-MC-Unique: Ub2sNWH4MemAqFOUSMmQ8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30889107BA99;
        Thu, 16 Apr 2020 09:51:51 +0000 (UTC)
Received: from [10.36.114.9] (ovpn-114-9.ams2.redhat.com [10.36.114.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 367D75DA7B;
        Thu, 16 Apr 2020 09:51:48 +0000 (UTC)
Subject: Re: [PATCH v2 00/20] Reorganize media Kconfig
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net,
        Helen Koike <helen.koike@collabora.com>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMFCQlmAYAGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl3pImkCGQEACgkQTd4Q
 9wD/g1o+VA//SFvIHUAvul05u6wKv/pIR6aICPdpF9EIgEU448g+7FfDgQwcEny1pbEzAmiw
 zAXIQ9H0NZh96lcq+yDLtONnXk/bEYWHHUA014A1wqcYNRY8RvY1+eVHb0uu0KYQoXkzvu+s
 Dncuguk470XPnscL27hs8PgOP6QjG4jt75K2LfZ0eAqTOUCZTJxA8A7E9+XTYuU0hs7QVrWJ
 jQdFxQbRMrYz7uP8KmTK9/Cnvqehgl4EzyRaZppshruKMeyheBgvgJd5On1wWq4ZUV5PFM4x
 II3QbD3EJfWbaJMR55jI9dMFa+vK7MFz3rhWOkEx/QR959lfdRSTXdxs8V3zDvChcmRVGN8U
 Vo93d1YNtWnA9w6oCW1dnDZ4kgQZZSBIjp6iHcA08apzh7DPi08jL7M9UQByeYGr8KuR4i6e
 RZI6xhlZerUScVzn35ONwOC91VdYiQgjemiVLq1WDDZ3B7DIzUZ4RQTOaIWdtXBWb8zWakt/
 ztGhsx0e39Gvt3391O1PgcA7ilhvqrBPemJrlb9xSPPRbaNAW39P8ws/UJnzSJqnHMVxbRZC
 Am4add/SM+OCP0w3xYss1jy9T+XdZa0lhUvJfLy7tNcjVG/sxkBXOaSC24MFPuwnoC9WvCVQ
 ZBxouph3kqc4Dt5X1EeXVLeba+466P1fe1rC8MbcwDkoUo65Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAiUEGAECAA8FAlXLn5ECGwwFCQlmAYAACgkQTd4Q
 9wD/g1qA6w/+M+ggFv+JdVsz5+ZIc6MSyGUozASX+bmIuPeIecc9UsFRatc91LuJCKMkD9Uv
 GOcWSeFpLrSGRQ1Z7EMzFVU//qVs6uzhsNk0RYMyS0B6oloW3FpyQ+zOVylFWQCzoyyf227y
 GW8HnXunJSC+4PtlL2AY4yZjAVAPLK2l6mhgClVXTQ/S7cBoTQKP+jvVJOoYkpnFxWE9pn4t
 H5QIFk7Ip8TKr5k3fXVWk4lnUi9MTF/5L/mWqdyIO1s7cjharQCstfWCzWrVeVctpVoDfJWp
 4LwTuQ5yEM2KcPeElLg5fR7WB2zH97oI6/Ko2DlovmfQqXh9xWozQt0iGy5tWzh6I0JrlcxJ
 ileZWLccC4XKD1037Hy2FLAjzfoWgwBLA6ULu0exOOdIa58H4PsXtkFPrUF980EEibUp0zFz
 GotRVekFAceUaRvAj7dh76cToeZkfsjAvBVb4COXuhgX6N4pofgNkW2AtgYu1nUsPAo+NftU
 CxrhjHtLn4QEBpkbErnXQyMjHpIatlYGutVMS91XTQXYydCh5crMPs7hYVsvnmGHIaB9ZMfB
 njnuI31KBiLUks+paRkHQlFcgS2N3gkRBzH7xSZ+t7Re3jvXdXEzKBbQ+dC3lpJB0wPnyMcX
 FOTT3aZT7IgePkt5iC/BKBk3hqKteTnJFeVIT7EC+a6YUFg=
Organization: Red Hat GmbH
Message-ID: <3411212c-b55d-f712-73ce-921d600bc290@redhat.com>
Date:   Thu, 16 Apr 2020 11:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.20 14:42, Mauro Carvalho Chehab wrote:
> This patch series do lots of reorg at the media Kconfig options.
> It also move test drivers from platform dir to a new one.
> 
> After this change, the main config is organized on menus, allowing to
> select:
> 
> 	- type of devices selection - the filtering options
> 	- Media core options - with API and other core stuff
> 	- Media core extra options
> 	- Media drivers
> 	- Media ancillary drivers
> 
> The "type of devices" menu has the filtering options for:
> 
> 	- Cameras and video grabbers
> 	- Analog TV
> 	- Digital TV
> 	- AM/FM radio receivers/transmitters
> 	- SDR
> 	- CEC
> 	- Embeded devices (SoC)
> 	- Test drivers
> 
> This way, one interested only on embedded devices can unselect
> everything but "Embedded devices (SoC)" option.
> 
> Distros for PC/Laptops can enable everything but 
> "Embedded devices (SoC)" and "Test drivers".
> 
> Users can select just what they want, without bothering with
> hundreds of options that he won't have any clue about their
> meanings.
> 
> Mauro Carvalho Chehab (20):
>   media: dvb-usb: auto-select CYPRESS_FIRMWARE
>   media: Kconfig: not all V4L2 platform drivers are for camera
>   media: pci: move VIDEO_PCI_SKELETON to a different Kconfig
>   media: reorganize the drivers menu options
>   media: Kconfig: update the MEDIA_SUPPORT help message
>   media: Kconfig: use a sub-menu to select supported devices
>   media: Kconfig: add an option to filter in/out the embedded drivers
>   media: split test drivers from platform directory
>   media: Kconfig: make filtering devices optional
>   media: Kconfig: move CEC-specific options to cec/Kconfig
>   media: Kconfig: move comment to siano include
>   media: Kconfig: move DVB-specific options to dvb-core/Kconfig
>   media: Kconfig: move V4L2 subdev API to v4l2-core/Kconfig
>   media: Kconfig: move drivers-specific TTPCI_EEPROM Kconfig var
>   media: Kconfig: move media controller core select to main Kconfig
>   media: Kconfig: better organize menu items
>   media: Kconfig: mode firewire comment to firewire/Kconfig
>   media: Kconfig: place all options under a sub-menu
>   media: Kconfig: move the position of sub-driver autoselection
>   media: Kconfig: on !EMBEDDED && !EXPERT, enable driver filtering
> 

There is a patch in linux-next (which I cannot find on lkml), which
breaks the build on s390x:

4be5e8648b0c287aefc6ac3f3a0b12c696054f43 is the first bad commit
commit 4be5e8648b0c287aefc6ac3f3a0b12c696054f43
Author: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Wed Apr 15 11:03:40 2020 +0200

    media: move CEC platform drivers to a separate directory

    As CEC support doesn't depend on MEDIA_SUPPORT, let's
    place the platform drivers outside the media menu.

    As a side effect, instead of depends on PCI, seco driver
    can select it (and DMI).

    Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
    Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


[linux1@rhkvm01 linux]$ make -j4
scripts/kconfig/conf  --syncconfig Kconfig
drivers/pci/Kconfig:16:error: recursive dependency detected!
drivers/pci/Kconfig:16: symbol PCI is selected by VIDEO_SECO_CEC
drivers/media/cec/platform/Kconfig:100: symbol VIDEO_SECO_CEC depends on
MEDIA_CEC_SUPPORT
drivers/media/cec/Kconfig:27:   symbol MEDIA_CEC_SUPPORT default is
visible depending on MEDIA_SUPPORT_FILTER
drivers/media/Kconfig:25:       symbol MEDIA_SUPPORT_FILTER depends on
MEDIA_SUPPORT
drivers/media/Kconfig:12:       symbol MEDIA_SUPPORT depends on HAS_IOMEM
arch/s390/Kconfig:721:  symbol HAS_IOMEM default value contains PCI
For a resolution refer to Documentation/kbuild/kconfig-language.rst
subsection "Kconfig recursive dependency limitations"

make[3]: *** [syncconfig] Error 1
make[2]: *** [syncconfig] Error 2
make[1]: *** [include/config/auto.conf.cmd] Error 2
make: *** [sub-make] Error 2



-- 
Thanks,

David / dhildenb

