Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B839C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2115B2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgEFP7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:59:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729431AbgEFP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:59:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 046FZfuI078664;
        Wed, 6 May 2020 11:58:29 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s4r5ea1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 11:58:29 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 046FtbkZ006829;
        Wed, 6 May 2020 15:58:28 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 30s0g6tcyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 15:58:28 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 046FwQCo28311840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 May 2020 15:58:26 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7249E7805E;
        Wed,  6 May 2020 15:58:27 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C99C978066;
        Wed,  6 May 2020 15:58:26 +0000 (GMT)
Received: from [9.163.13.169] (unknown [9.163.13.169])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  6 May 2020 15:58:26 +0000 (GMT)
Subject: Re: [PATCH 3/3] hwmon: (occ) Add new temperature sensor type
To:     Guenter Roeck <linux@roeck-us.net>,
        Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, robh+dt@kernel.org
References: <20200501150833.5251-1-eajames@linux.ibm.com>
 <20200501150833.5251-4-eajames@linux.ibm.com>
 <20200506155704.GA30543@roeck-us.net>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Message-ID: <68296e99-bd7e-03dd-073d-03487b7a265e@linux.vnet.ibm.com>
Date:   Wed, 6 May 2020 10:58:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506155704.GA30543@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-06_08:2020-05-05,2020-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/6/20 10:57 AM, Guenter Roeck wrote:
> On Fri, May 01, 2020 at 10:08:33AM -0500, Eddie James wrote:
>> The latest version of the On-Chip Controller (OCC) has a different
>> format for the temperature sensor data. Add a new temperature sensor
>> version to handle this data.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> For my reference:
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> I assume this depends on at least patch 2 of the series, so we'll have
> to wait for that to be accepted.


Thanks Guenter. Yes that's correct.

Eddie


>
> Guenter
>
>> ---
>>   drivers/hwmon/occ/common.c | 75 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>
>> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
>> index 30e18eb60da7..52af0e728232 100644
>> --- a/drivers/hwmon/occ/common.c
>> +++ b/drivers/hwmon/occ/common.c
>> @@ -41,6 +41,14 @@ struct temp_sensor_2 {
>>   	u8 value;
>>   } __packed;
>>   
>> +struct temp_sensor_10 {
>> +	u32 sensor_id;
>> +	u8 fru_type;
>> +	u8 value;
>> +	u8 throttle;
>> +	u8 reserved;
>> +} __packed;
>> +
>>   struct freq_sensor_1 {
>>   	u16 sensor_id;
>>   	u16 value;
>> @@ -307,6 +315,60 @@ static ssize_t occ_show_temp_2(struct device *dev,
>>   	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
>>   }
>>   
>> +static ssize_t occ_show_temp_10(struct device *dev,
>> +				struct device_attribute *attr, char *buf)
>> +{
>> +	int rc;
>> +	u32 val = 0;
>> +	struct temp_sensor_10 *temp;
>> +	struct occ *occ = dev_get_drvdata(dev);
>> +	struct occ_sensors *sensors = &occ->sensors;
>> +	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
>> +
>> +	rc = occ_update_response(occ);
>> +	if (rc)
>> +		return rc;
>> +
>> +	temp = ((struct temp_sensor_10 *)sensors->temp.data) + sattr->index;
>> +
>> +	switch (sattr->nr) {
>> +	case 0:
>> +		val = get_unaligned_be32(&temp->sensor_id);
>> +		break;
>> +	case 1:
>> +		val = temp->value;
>> +		if (val == OCC_TEMP_SENSOR_FAULT)
>> +			return -EREMOTEIO;
>> +
>> +		/*
>> +		 * VRM doesn't return temperature, only alarm bit. This
>> +		 * attribute maps to tempX_alarm instead of tempX_input for
>> +		 * VRM
>> +		 */
>> +		if (temp->fru_type != OCC_FRU_TYPE_VRM) {
>> +			/* sensor not ready */
>> +			if (val == 0)
>> +				return -EAGAIN;
>> +
>> +			val *= 1000;
>> +		}
>> +		break;
>> +	case 2:
>> +		val = temp->fru_type;
>> +		break;
>> +	case 3:
>> +		val = temp->value == OCC_TEMP_SENSOR_FAULT;
>> +		break;
>> +	case 4:
>> +		val = temp->throttle * 1000;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
>> +}
>> +
>>   static ssize_t occ_show_freq_1(struct device *dev,
>>   			       struct device_attribute *attr, char *buf)
>>   {
>> @@ -745,6 +807,10 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>>   		num_attrs += (sensors->temp.num_sensors * 4);
>>   		show_temp = occ_show_temp_2;
>>   		break;
>> +	case 0x10:
>> +		num_attrs += (sensors->temp.num_sensors * 5);
>> +		show_temp = occ_show_temp_10;
>> +		break;
>>   	default:
>>   		sensors->temp.num_sensors = 0;
>>   	}
>> @@ -844,6 +910,15 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>>   			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
>>   						     show_temp, NULL, 3, i);
>>   			attr++;
>> +
>> +			if (sensors->temp.version == 0x10) {
>> +				snprintf(attr->name, sizeof(attr->name),
>> +					 "temp%d_max", s);
>> +				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
>> +							     show_temp, NULL,
>> +							     4, i);
>> +				attr++;
>> +			}
>>   		}
>>   	}
>>   
