Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B13C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9932067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598290576;
	bh=jajdHKpA/OzDTtEh8dKNeYgjCDO10elq+9ueBldgEE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yYjuMjiHtdx7wngskon8zglWjAfx4Q/bnA180YOhaD8xg0Hzsqk0huu4X8z0y59qh
	 VPGZN118J7yt4bBMbzZkx/qUBhJyT5wN10AFtfY/qMX6V83O0bcXgNS4XRyLUKITlN
	 B5wGOF/uWccQFFCt/zR1XQDimypZOwkksetnDZkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgHXRgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:36:12 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:32937 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbgHXRfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:35:44 -0400
Received: by mail-il1-f196.google.com with SMTP id r13so8006273iln.0;
        Mon, 24 Aug 2020 10:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RvtZJRVLDDkAIrUgbsaYYYpc0rnswzQQW7bcfytrw2k=;
        b=gkVyKCnPdyA2t1+ahPgIG8t+LTh+f4lVsB57t7vbiZXAmbefP7uAuVJkPkyQWxhlTV
         rwGcsP/yy5pEdKYlyIamBfO+M3fT+j3ZPjt4Vp4FRejlZpCQ2Ho1r0bWCTWOld4+bBMO
         2fgeWzmXbRt0wWRysqndmIcmqrhSxYm3VahYr05bcSz6nMed3Qi/yvEE4tCWczbRer9C
         Qviw11nV4HRYhYAYu0bJN8on4XTUSE/zKKRe8vLwPBs9e1Fhk+esRrM2ksijWB40A2QF
         vDxG0Hje3S2u1llSz4TNtNxXkiYmhZGEVaNKgucXZ/dhDO8M+prT2QtSWa5gLJfJM32r
         cyCA==
X-Gm-Message-State: AOAM532cBgsJNlagDfVnn6ZqlSpoTwilF/gEnsq5wXpANDB7mesZkNKT
        GaviGMVNNZu8c0J1bLStQw==
X-Google-Smtp-Source: ABdhPJx3PuEeH9ZUnf9J9dEAAzUONc8w1DwyS3NKEIgjuNlhebcqOFLr3iHJXgxxkvBQXG3pOmyM1g==
X-Received: by 2002:a92:7b10:: with SMTP id w16mr5453892ilc.92.1598290542423;
        Mon, 24 Aug 2020 10:35:42 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id p21sm7100806ioj.10.2020.08.24.10.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:35:41 -0700 (PDT)
Received: (nullmailer pid 2943902 invoked by uid 1000);
        Mon, 24 Aug 2020 17:35:39 -0000
Date:   Mon, 24 Aug 2020 11:35:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sagar Kadam <sagar.kadam@sifive.com>
Cc:     aou@eecs.berkeley.edu, devicetree@vger.kernel.org,
        paul.walmsley@sifive.com, robh+dt@kernel.org, yash.shah@sifive.com,
        palmer@dabbelt.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/1] dt-bindings: riscv: sifive-l2-cache: convert
 bindings to json-schema
Message-ID: <20200824173539.GA2939042@bogus>
References: <1598255421-8274-1-git-send-email-sagar.kadam@sifive.com>
 <1598255421-8274-2-git-send-email-sagar.kadam@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598255421-8274-2-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 13:20:21 +0530, Sagar Kadam wrote:
> Convert the device tree bindings for the SiFive's FU540-C000 SoC's L2 Cache
> controller to YAML format.
> 
> Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> ---
>  .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 ------------
>  .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 93 ++++++++++++++++++++++
>  2 files changed, 93 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l2-cache: $nodename:0: 'l2-cache' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l2-cache: compatible:0: 'cache' is not one of ['sifive,fu540-c000-ccache']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l2-cache: compatible: ['cache'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l2-cache: 'l3-cache' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l2-cache: 'cache-block-size' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l2-cache: 'cache-level' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l2-cache: 'cache-sets' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l2-cache: 'cache-size' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l2-cache: 'cache-unified' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l2-cache: 'reg' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l2-cache: {'compatible': ['cache'], 'next-level-cache': [[2]], 'phandle': [[1]], 'l3-cache': {'compatible': ['cache'], 'phandle': [[2]]}, '$nodename': ['l2-cache']} is not valid under any of the given schemas
{'$filename': '/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml',
 '$id': 'http://devicetree.org/schemas/riscv/sifive-l2-cache.yaml#',
 '$schema': 'http://devicetree.org/meta-schemas/core.yaml#',
 '$select_validator': <jsonschema.validators.create.<locals>.Validator object at 0x7efcd84bc850>,
 'additionalProperties': False,
 'allOf': [{'$ref': '/schemas/cache-controller.yaml#'}],
 'oneOf': [{'required': ['interrupts']},
           {'required': ['interrupts-extended']}],
 'patternProperties': {'pinctrl-[0-9]+': True},
 'properties': {'$nodename': True,
                'cache-block-size': {'additionalItems': False,
                                     'items': [{'additionalItems': False,
                                                'items': [{'const': 64}],
                                                'maxItems': 1,
                                                'minItems': 1,
                                                'type': 'array'}],
                                     'maxItems': 1,
                                     'minItems': 1,
                                     'type': 'array'},
                'cache-level': {'additionalItems': False,
                                'items': [{'additionalItems': False,
                                           'items': [{'const': 2}],
                                           'maxItems': 1,
                                           'minItems': 1,
                                           'type': 'array'}],
                                'maxItems': 1,
                                'minItems': 1,
                                'type': 'array'},
                'cache-sets': {'additionalItems': False,
                               'items': [{'additionalItems': False,
                                          'items': [{'const': 1024}],
                                          'maxItems': 1,
                                          'minItems': 1,
                                          'type': 'array'}],
                               'maxItems': 1,
                               'minItems': 1,
                               'type': 'array'},
                'cache-size': {'additionalItems': False,
                               'items': [{'additionalItems': False,
                                          'items': [{'const': 2097152}],
                                          'maxItems': 1,
                                          'minItems': 1,
                                          'type': 'array'}],
                               'maxItems': 1,
                               'minItems': 1,
                               'type': 'array'},
                'cache-unified': True,
                'compatible': {'additionalItems': False,
                               'items': [{'enum': ['sifive,fu540-c000-ccache']},
                                         {'const': 'cache'}],
                               'maxItems': 2,
                               'minItems': 2,
                               'type': 'array'},
                'interrupt-parent': True,
                'interrupts': {'maxItems': 3, 'minItems': 1},
                'interrupts-extended': {'maxItems': 3, 'minItems': 1},
                'memory-region': {},
                'next-level-cache': {},
                'phandle': True,
                'pinctrl-names': True,
                'reg': {'maxItems': 1, 'minItems': 1},
                'status': True},
 'required': ['compatible',
              'cache-block-size',
              'cache-level',
              'cache-sets',
              'cache-size',
              'cache-unified',
              'reg'],
 'select': {'properties': {'compatible': {'contains': {'enum': ['cache',
                                                                'sifive,fu540-c000-ccache']}}},
            'required': ['compatible']},
 'title': 'SiFive L2 Cache Controller'} (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l2-cache: 'interrupts' is a required property

	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l3-cache: $nodename:0: 'l3-cache' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l3-cache: compatible:0: 'cache' is not one of ['sifive,fu540-c000-ccache']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l3-cache: compatible: ['cache'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l3-cache: 'cache-block-size' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l3-cache: 'cache-level' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l3-cache: 'cache-sets' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l3-cache: 'cache-size' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l3-cache: 'cache-unified' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l3-cache: 'reg' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l3-cache: {'compatible': ['cache'], 'phandle': [[2]], '$nodename': ['l3-cache']} is not valid under any of the given schemas
{'$filename': '/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml',
 '$id': 'http://devicetree.org/schemas/riscv/sifive-l2-cache.yaml#',
 '$schema': 'http://devicetree.org/meta-schemas/core.yaml#',
 '$select_validator': <jsonschema.validators.create.<locals>.Validator object at 0x7efcd84bc850>,
 'additionalProperties': False,
 'allOf': [{'$ref': '/schemas/cache-controller.yaml#'}],
 'oneOf': [{'required': ['interrupts']},
           {'required': ['interrupts-extended']}],
 'patternProperties': {'pinctrl-[0-9]+': True},
 'properties': {'$nodename': True,
                'cache-block-size': {'additionalItems': False,
                                     'items': [{'additionalItems': False,
                                                'items': [{'const': 64}],
                                                'maxItems': 1,
                                                'minItems': 1,
                                                'type': 'array'}],
                                     'maxItems': 1,
                                     'minItems': 1,
                                     'type': 'array'},
                'cache-level': {'additionalItems': False,
                                'items': [{'additionalItems': False,
                                           'items': [{'const': 2}],
                                           'maxItems': 1,
                                           'minItems': 1,
                                           'type': 'array'}],
                                'maxItems': 1,
                                'minItems': 1,
                                'type': 'array'},
                'cache-sets': {'additionalItems': False,
                               'items': [{'additionalItems': False,
                                          'items': [{'const': 1024}],
                                          'maxItems': 1,
                                          'minItems': 1,
                                          'type': 'array'}],
                               'maxItems': 1,
                               'minItems': 1,
                               'type': 'array'},
                'cache-size': {'additionalItems': False,
                               'items': [{'additionalItems': False,
                                          'items': [{'const': 2097152}],
                                          'maxItems': 1,
                                          'minItems': 1,
                                          'type': 'array'}],
                               'maxItems': 1,
                               'minItems': 1,
                               'type': 'array'},
                'cache-unified': True,
                'compatible': {'additionalItems': False,
                               'items': [{'enum': ['sifive,fu540-c000-ccache']},
                                         {'const': 'cache'}],
                               'maxItems': 2,
                               'minItems': 2,
                               'type': 'array'},
                'interrupt-parent': True,
                'interrupts': {'maxItems': 3, 'minItems': 1},
                'interrupts-extended': {'maxItems': 3, 'minItems': 1},
                'memory-region': {},
                'next-level-cache': {},
                'phandle': True,
                'pinctrl-names': True,
                'reg': {'maxItems': 1, 'minItems': 1},
                'status': True},
 'required': ['compatible',
              'cache-block-size',
              'cache-level',
              'cache-sets',
              'cache-size',
              'cache-unified',
              'reg'],
 'select': {'properties': {'compatible': {'contains': {'enum': ['cache',
                                                                'sifive,fu540-c000-ccache']}}},
            'required': ['compatible']},
 'title': 'SiFive L2 Cache Controller'} (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.example.dt.yaml: l3-cache: 'interrupts' is a required property

	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/renesas,rcar-sysc.example.dt.yaml: cache-controller-0: $nodename:0: 'cache-controller-0' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/renesas,rcar-sysc.example.dt.yaml: cache-controller-0: compatible:0: 'cache' is not one of ['sifive,fu540-c000-ccache']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/renesas,rcar-sysc.example.dt.yaml: cache-controller-0: compatible: ['cache'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/renesas,rcar-sysc.example.dt.yaml: cache-controller-0: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/renesas,rcar-sysc.example.dt.yaml: cache-controller-0: 'cache-block-size' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/renesas,rcar-sysc.example.dt.yaml: cache-controller-0: 'cache-sets' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/renesas,rcar-sysc.example.dt.yaml: cache-controller-0: 'cache-size' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/renesas,rcar-sysc.example.dt.yaml: cache-controller-0: 'reg' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/renesas,rcar-sysc.example.dt.yaml: cache-controller-0: {'compatible': ['cache'], 'power-domains': [[1, 12]], 'cache-unified': True, 'cache-level': [[2]], '$nodename': ['cache-controller-0']} is not valid under any of the given schemas
{'$filename': '/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml',
 '$id': 'http://devicetree.org/schemas/riscv/sifive-l2-cache.yaml#',
 '$schema': 'http://devicetree.org/meta-schemas/core.yaml#',
 '$select_validator': <jsonschema.validators.create.<locals>.Validator object at 0x7f26dd3928b0>,
 'additionalProperties': False,
 'allOf': [{'$ref': '/schemas/cache-controller.yaml#'}],
 'oneOf': [{'required': ['interrupts']},
           {'required': ['interrupts-extended']}],
 'patternProperties': {'pinctrl-[0-9]+': True},
 'properties': {'$nodename': True,
                'cache-block-size': {'additionalItems': False,
                                     'items': [{'additionalItems': False,
                                                'items': [{'const': 64}],
                                                'maxItems': 1,
                                                'minItems': 1,
                                                'type': 'array'}],
                                     'maxItems': 1,
                                     'minItems': 1,
                                     'type': 'array'},
                'cache-level': {'additionalItems': False,
                                'items': [{'additionalItems': False,
                                           'items': [{'const': 2}],
                                           'maxItems': 1,
                                           'minItems': 1,
                                           'type': 'array'}],
                                'maxItems': 1,
                                'minItems': 1,
                                'type': 'array'},
                'cache-sets': {'additionalItems': False,
                               'items': [{'additionalItems': False,
                                          'items': [{'const': 1024}],
                                          'maxItems': 1,
                                          'minItems': 1,
                                          'type': 'array'}],
                               'maxItems': 1,
                               'minItems': 1,
                               'type': 'array'},
                'cache-size': {'additionalItems': False,
                               'items': [{'additionalItems': False,
                                          'items': [{'const': 2097152}],
                                          'maxItems': 1,
                                          'minItems': 1,
                                          'type': 'array'}],
                               'maxItems': 1,
                               'minItems': 1,
                               'type': 'array'},
                'cache-unified': True,
                'compatible': {'additionalItems': False,
                               'items': [{'enum': ['sifive,fu540-c000-ccache']},
                                         {'const': 'cache'}],
                               'maxItems': 2,
                               'minItems': 2,
                               'type': 'array'},
                'interrupt-parent': True,
                'interrupts': {'maxItems': 3, 'minItems': 1},
                'interrupts-extended': {'maxItems': 3, 'minItems': 1},
                'memory-region': {},
                'next-level-cache': {},
                'phandle': True,
                'pinctrl-names': True,
                'reg': {'maxItems': 1, 'minItems': 1},
                'status': True},
 'required': ['compatible',
              'cache-block-size',
              'cache-level',
              'cache-sets',
              'cache-size',
              'cache-unified',
              'reg'],
 'select': {'properties': {'compatible': {'contains': {'enum': ['cache',
                                                                'sifive,fu540-c000-ccache']}}},
            'required': ['compatible']},
 'title': 'SiFive L2 Cache Controller'} (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/renesas,rcar-sysc.example.dt.yaml: cache-controller-0: 'interrupts' is a required property

	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml


See https://patchwork.ozlabs.org/patch/1350111

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

